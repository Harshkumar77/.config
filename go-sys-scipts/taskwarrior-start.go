package main

import (
	"fmt"
	"os/exec"
	"strings"
)

func extractID(stdout []byte) string {
	column := strings.Split(strings.Split(string(stdout), "\n")[3], " ")
	// first non empty element
	for _, char := range column {
		if char == "" {
			continue
		}
		return char
	}
	return ""

}


func main() {

	stdout, err := exec.Command(
		"task",
		"next",
		"limit:1",
	).Output()

	if err != nil {
		fmt.Println("No available task")
		return
	}

	id := extractID(stdout)

	stdout, err = exec.Command(
		"task",
		"start",
		id,
	).Output()
	if err != nil {
		fmt.Println("Couldn't start task:" + id + "-")
		return
	}
	fmt.Println(string(stdout))

	stdout, err = exec.Command(
		"timew",
	).Output()
	if err != nil {
		return
	}
	fmt.Println(string(stdout))
}
