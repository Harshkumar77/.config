//$HOME/.nix-profile/bin/go run $0 $@ ; exit

package main

import (
	"fmt"
	"log"
	"math/rand"
	"time"
)

func main() {
	now := time.Now()
	FORMAT := "2006-01-02"
	dates := []string{
		"2024-06-19",
	}
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

	daysTillNextBday := fmt.Sprintf(
		"%.0f",
		time.Date(
			nextBdayYear, time.April, 11, 0, 0, 0, 0, time.UTC,
		).Sub(now).Hours()/24,
	)

	daysTillNextYear := 365 - now.YearDay()

	output = append(output, fmt.Sprint(daysTillNextYear))
	output = append(output, daysTillNextBday)
	output = append(output, fmt.Sprint(age))

	outputFormat := ""

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
		outputFormat += "%v "
	}

	print(outputFormat)

	fmt.Printf("%v %v %v\n", output[0], output[1], output[2])
}
