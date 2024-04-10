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
	id := strings.Split(strings.Split(output, "\n")[3], " ")[1]

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

	var args []string
	args = append(
		args,
		"from",
		"2022-01-01",
		"summary",
		description,
		// project,
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

	splited_timew_output := strings.Split(string(stdout), "\n")
	time_elapsed := strings.ReplaceAll(splited_timew_output[len(splited_timew_output)-3], " ", "")

	fmt.Println(time_elapsed, "@" , description)
}
