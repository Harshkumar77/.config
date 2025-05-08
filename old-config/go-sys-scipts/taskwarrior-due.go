package main

import (
	"fmt"
	"os/exec"
)

func main() {
	out, _ := exec.Command(
		"task", "next", "limit:1", "|", "tail", "-n", "+4", "|", "head", "-n", "1", "|", "sed", "'s/^", "//'", "|", "cut", "-d", "'", "'", "-f1",
	).Output()
	fmt.Println(string(out))
	// task _get .description

}
