package main

import (
	"fmt"
	"strings"
)

func main() {
	test := []string{"“", "l", "0", "l", ".", ".", "."}
	fmt.Println(test[:len(test) - 3])
	fmt.Println(test[1:len(test)])
	WTLC := strings.ToLower("Pierre’s")
	fmt.Println(WTLC)
}
