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
		fmt.Println("No Tasks in Taskwarrior")
		return
	}

	imp_task_id := extractID(stdout)

	stdout, err = exec.Command(
		"task",
		"+ACTIVE",
		"limit:1",
	).Output()

	if err != nil {
		stdout, err = exec.Command(
			"task",
			"_get",
			imp_task_id+".description",
		).Output()
		if err != nil {
			fmt.Println("Unable to fetch active task description id:" + imp_task_id)
			return
		}

		imp_task_description := strings.ReplaceAll(string(stdout), "\n", "")
		fmt.Print("NEXT TASK: ", imp_task_description)
		return
	}

	active_task_id := extractID(stdout)

	stdout, err = exec.Command(
		"task",
		"_get",
		active_task_id+".description",
	).Output()
	if err != nil {
		fmt.Println("Unable to fetch active task description id:" + active_task_id)
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

	fmt.Print(time_elapsed, " @ ", active_task_description)
	if imp_task_id != active_task_id {
		stdout, err = exec.Command(
			"task",
			"_get",
			imp_task_id+".description",
		).Output()
		if err != nil {
			fmt.Println("Unable to fetch active task description id:" + imp_task_id)
			return
		}

		imp_task_description := strings.ReplaceAll(string(stdout), "\n", "")
		fmt.Print(" MORE IMPORTANT TASK: ", imp_task_description)
	}
}
