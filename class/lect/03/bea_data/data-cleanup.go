package main

import (
	"encoding/csv"
	"fmt"
	"regexp"
	"strings"

	"git.q8s.co/pschlump/read_lines"
)

var marker = ",,,,,,,"
var end_marker = "(NA) Not available,,,,,,,"
var skip1 = ":,,,,"
var skip2 = " + "

// Virginia,Combination areas3:,,,,,,,
// Virginia,Albemarle + Charlottesville,74603,75885,77606,7,1.7,2.3,104

// package read_lines
// type FileProcess func(line, file_name string, line_no int) (err error)
// func ReadFileAsLines(filePath string, fx FileProcess) (err error) {

func main() {
	filePath := "lapi1121.csv"
	st := 0
	var state_name string
	err := read_lines.ReadFileAsLines(filePath, func(line, file_name string, line_no int) (err error) {
		line = strings.Replace(line, "--", "0", -1)
		field := strings.Split(line, ",")
		if (st == 0 || st == 2) && line == marker {
			st = 1
		} else if (st == 0 || st == 2) && strings.Contains(line, skip1) {
		} else if (st == 0 || st == 2) && strings.Contains(line, skip2) {
		} else if (st == 0 || st == 2) && line == end_marker {
			st = 4
		} else if st == 1 {
			state_name = field[0]
			st = 2
		} else if st == 2 {
			field = SplitCSV(line)
			// fmt.Printf("%s,%s\n", state_name, line)
			fmt.Printf("%s,", state_name)
			field[1] = strings.Replace(field[1], ",", "", -1)
			field[2] = strings.Replace(field[2], ",", "", -1)
			field[3] = strings.Replace(field[3], ",", "", -1)
			note := regexp.MustCompile(` \(includ.*\)`)
			field[0] = note.ReplaceAllString(field[0], "")
			for i, v := range field {
				if i == len(field)-1 {
					fmt.Printf("%s\n", v)
				} else {
					fmt.Printf("%s,", v)
				}
			}
		}
		return
	})
	if err != nil {
		fmt.Printf("Error: %s\n", err)
	}
}

func SplitCSV(in string) (rv []string) {
	r := csv.NewReader(strings.NewReader(in))
	rv, _ = r.Read()
	return
}
