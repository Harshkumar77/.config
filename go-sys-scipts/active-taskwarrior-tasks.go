package main

import (
	"fmt"
	"os/exec"
	"strings"
)

func main() {

	cmd := exec.Command(
		"task",
		"+ACTIVE",
		"limit:1",
	)
	stdout, err := cmd.Output()

	if err != nil {
		fmt.Println("No active task")
		return
	}
	var output string

	output = string(stdout)
	id := strings.Split(strings.Split(output, "\n")[3], " ")[0]

	// task _get .description
	fmt.Println(id)
}
