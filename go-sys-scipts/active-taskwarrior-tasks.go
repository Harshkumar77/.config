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

	output := string(stdout)
	id := strings.Split(strings.Split(output, "\n")[3], " ")[0]

	// task _get .description
	cmd = exec.Command(
		"task",
		"_get",
		id+".description",
	)
	stdout, err = cmd.Output()
	if err != nil {
		fmt.Println("No active task")
		return
	}

	description := string(stdout)

	cmd = exec.Command(
		"task",
		"_get",
		id+".tags",
	)
	stdout, err = cmd.Output()
	if err != nil {
		fmt.Println("No active task")
		return
	}

	tags := string(stdout)

	cmd = exec.Command(
		"task",
		"_get",
		id + ".project",
	)
	stdout, err = cmd.Output()
	if err != nil {
		fmt.Println("No active task")
		return
	}

	project := string(stdout)
	fmt.Print(tags , description , project)
}
