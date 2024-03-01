package main

import (
	"fmt"
	"os/exec"
	"strings"
)

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

	output := string(stdout)
	id := strings.Split(strings.Split(output, "\n")[3], " ")[0]

	stdout, err = exec.Command(
		"task",
		"start",
		id,
	).Output()
	if err != nil {
		fmt.Println("Couldn't start task:" + id)
		return
	}

	fmt.Println(string(stdout))
}
