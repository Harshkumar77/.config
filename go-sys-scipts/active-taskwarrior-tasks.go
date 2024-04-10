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
		fmt.Println("No Tasks in Taskwarrior")
		return
	}

	imp_task_id := strings.Split(strings.Split(string(stdout), "\n")[3], " ")[1]

	stdout, err = exec.Command(
		"task",
		"+ACTIVE",
		"limit:1",
	).Output()

	if err != nil {
		fmt.Println("No active task")
		return
	}

	active_task_id := strings.Split(strings.Split(string(stdout), "\n")[3], " ")[1]

	stdout, err = exec.Command(
		"task",
		"_get",
		active_task_id+".description",
	).Output()
	if err != nil {
		fmt.Println("No active task")
		return
	}

	active_task_description := strings.ReplaceAll(string(stdout), "\n", "")

	stdout, err = exec.Command(
		"task",
		"_get",
		active_task_id+".tags",
	).Output()

	if err != nil {
		fmt.Println("No active task")
		return
	}

	tagsRaw := strings.ReplaceAll(string(stdout), "\n", "")
	tags := strings.Split(tagsRaw, ",")

	stdout, err = exec.Command(
		"task",
		"_get",
		active_task_id+".project",
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
		active_task_description,
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

	fmt.Println(time_elapsed, "@" , active_task_description)
}
