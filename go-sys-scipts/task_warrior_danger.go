package main

import (
	"fmt"
	"log"
	"os/exec"
)

func main() {
	var output, err = exec.Command("task", "due.before:today").Output()
	if err != nil {
		log.Fatal(err)
	}
	if string(output[:]) != "No matches." {
		fmt.Println("󰚌󰚌󰚌󰚌󰚌󰚌")
		return
	}

	output, err = exec.Command("task", "due.after:tomorrow", "and", "due.before:tomorrow+1day").Output()
	if err != nil {
		log.Fatal(err)
	}
	if string(output[:]) != "No matches." {
		fmt.Println("󰜎󰜎󰜎")
		return
	}

	output, err = exec.Command("task").Output()
	if err != nil {
		log.Fatal(err)
	}
	if string(output[:]) != "No matches." {
		fmt.Println("󰞍󰞍󰞍󰞍󰞍󰞍")
		return
	}

	fmt.Println("Good job or add some tasks u lazy")

}
