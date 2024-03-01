package main

import (
	"fmt"
	"os/exec"
	"strings"
)

func main() {

	stdout, err := exec.Command(
		"task",
		"+ACTIVE",
		"limit:1",
	).Output()

	if err != nil {
		fmt.Println("No active task")
		return
	}

	output := string(stdout)
	id := strings.Split(strings.Split(output, "\n")[3], " ")[0]

	// task _get .description
	stdout, err = exec.Command(
		"task",
		"_get",
		id+".description",
	).Output()
	if err != nil {
		fmt.Println("No active task")
		return
	}

	description := string(stdout)
	description = strings.ReplaceAll(description, "\n", "")

	stdout, err = exec.Command(
		"task",
		"_get",
		id+".tags",
	).Output()

	if err != nil {
		fmt.Println("No active task")
		return
	}

	// tags := string(stdout)
	// tags = strings.ReplaceAll(tags, ",", " ")
	// tags = strings.ReplaceAll(tags, "\n", "")
	tagsRaw := string(stdout)
	tagsRaw = strings.ReplaceAll(tagsRaw, "\n", "")
	tags := strings.Split(tagsRaw, ",")

	stdout, err = exec.Command(
		"task",
		"_get",
		id+".project",
	).Output()
	if err != nil {
		fmt.Println("No active task")
		return
	}

	project := string(stdout)
	project = strings.ReplaceAll(project, ",", " ")
	project = strings.ReplaceAll(project, "\n", "")

	// stdout, err = exec.Command(
	// 	"timew",
	// 	"summary",
	// 	description,
	// 	project,
	// 	tags,
	// ).Output()
	var args []string
	args = append(
		args,
		"summary",
		description,
		project,
	)
	for _, t := range tags {
		args = append(args, t)
	}
	stdout, err = exec.Command(
		"timew",
		args...,
	).Output()
	if err != nil {
		fmt.Println("No active task")
		return
	}

	timew := string(stdout)
	fmt.Println(tags, description, project, id, timew)
}
