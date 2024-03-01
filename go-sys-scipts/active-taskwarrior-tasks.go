package main

import "os/exec"
import  "fmt"

func main() {

    cmd := exec.Command(
		"task",
		"+ACTIVE",
		"next",
		"limit:1",
	)
    stdout, err := cmd.Output()

    if err != nil {
        fmt.Println(err.Error())
        return
    }

    fmt.Print(string(stdout))
}
