//$HOME/.nix-profile/bin/go run $0 $@ ; exit

package main

import (
	"fmt"
	"log"
	"math/rand"
	"time"
)

func main() {
	dates := []string{
		// /* Birthday */ "2025-04-11", 
		/* GS3 Deadline */ "2025-01-06", 
		/* Prelims Date */ "2025-05-01", 
		/* Year End */ fmt.Sprintf("%v", time.Now().Year()+1) + "-01-01",
	}

	now := time.Now()
	FORMAT := "2006-01-02"
	output := []string{}
	for i := 0; i < len(dates); i++ {
		parsedDate, err := time.Parse(FORMAT, dates[i])
		if err != nil {
			log.Panic(err)
		}
		output = append(output, fmt.Sprintf("%.0f", parsedDate.Sub(now).Hours()/24))
	}
	age := now.Local().Year() - 2003 - 1

	nextBdayYear := now.Year()

	if now.Month() > time.April ||
		now.Month() == time.April && now.Day() > 11 {
		nextBdayYear++
		age++
	}

	output = append(output, fmt.Sprint(age))

	for i := len(output) - 1; i > 0; i-- {
		swapIdx := rand.Intn(i)
		temp := output[swapIdx]
		output[swapIdx] = output[i]
		output[i] = temp
	}
	for i := len(output) - 1; i > 0; i-- {
		swapIdx := rand.Intn(i)
		temp := output[swapIdx]
		output[swapIdx] = output[i]
		output[i] = temp
	}

	for i := len(output) - 1; i >= 0; i-- {
		fmt.Printf("%v ", output[i])
	}

}
