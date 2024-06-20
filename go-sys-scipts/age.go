//$HOME/.nix-profile/bin/go run $0 $@ ; exit

package main

import (
	"fmt"
	"math/rand"
	"time"
)

func main() {
	FORMAT := "2006-12-14"
	dates := []string{
		"2024-06-19",
	}
	now := time.Now()
	age := now.Local().Year() - 2003 - 1

	nextBdayYear := now.Year()

	if now.Month() > time.April ||
		now.Month() == time.April && now.Day() > 11 {
		nextBdayYear++
		age++
	}

	daysTillNextBday := fmt.Sprintf(
		"%.0f",
		time.Date(
			nextBdayYear, time.April, 11, 0, 0, 0, 0, time.UTC,
		).Sub(now).Hours()/24,
	)

	daysTillNextYear := 365 - now.YearDay()

	output := []string{
		fmt.Sprint(daysTillNextYear),
		daysTillNextBday,
		fmt.Sprint(age),
	}

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

	fmt.Printf("%v %v %v\n", output[0], output[1], output[2])
}
