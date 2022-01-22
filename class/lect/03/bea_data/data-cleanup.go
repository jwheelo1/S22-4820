package main

import (
	"fmt"
	"strings"

	"git.q8s.co/pschlump/read_lines"
)

var marker = ",,,,,,,"
var end_marker = "(NA) Not available,,,,,,,"

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
		} else if (st == 0 || st == 2) && line == end_marker {
			st = 4
		} else if st == 1 {
			state_name = field[0]
			st = 2
		} else if st == 2 {
			fmt.Printf("%s,%s\n", state_name, line)
		}
		return
	})
	if err != nil {
		fmt.Printf("Error: %s\n", err)
	}
}
