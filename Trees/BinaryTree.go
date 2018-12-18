package main

import (
	"bufio"
	"fmt"
	"io/ioutil"
	"os"
	"strconv"
	"strings"
)

type Node struct {
	Left    *Node
	Right   *Node
	Value   string
	Counter int
}

func newNode(val string) *Node {
	return &Node{nil, nil, val, 1}
}

func insert(t *Node, word string) *Node {
	if length == 0 {
		length++
		mapLengthCompare[length] = compare
		compare = 0
		return newNode(word)
	}

	if t == nil {
		length++
		mapLengthCompare[length] = compare
		compare = 0
		return newNode(word)
	}
	compare++
	switch strings.Compare(word, t.Value) {
	case 1:
		t.Right = insert(t.Right, word)
		return t
	case -1:
		t.Left = insert(t.Left, word)
		return t
	default: //==0
		t.Counter++
		mapLengthCompare[length] = compare
		compare = 0
		return t
	}
}

func main() {
	var tree *Node

	txt := "text_eng.txt"
	file, err := ioutil.ReadFile(txt)
	if err != nil {
		fmt.Println(err)
	}
	content := string(file)
	scanner := bufio.NewScanner(strings.NewReader(content))
	scanner.Split(bufio.ScanWords)
	for scanner.Scan() {
		word := scanner.Text()
		newWord, isOk := TextParsing(word)
		if !isOk {
			continue
		}
		newWord = strings.ToLower(newWord)
		tree = insert(tree, newWord)
	}
	//showMe(tree, 0)
	findTop(tree)

	sortedTopWords := sortStructByValue(topWords)

	for ind, val := range sortedTopWords {
		fmt.Printf("IND: %v, WORD: %v, COUNT: %v\n", ind, val.Key, val.Value)
	}

	X := "./points/lengthBT.txt"
	Y := "./points/compareBT.txt"
	fileX, err := os.Create(X)
	defer fileX.Close()
	if err != nil {
		fmt.Println(err)
	}
	fileY, err := os.Create(Y)
	defer fileY.Close()
	if err != nil {
		fmt.Println(err)
	}
	sortedLengthCompare := sortStructByKey(mapLengthCompare)

	for _, value := range sortedLengthCompare {
		compare := strconv.Itoa(value.Value.(int))
		length := strconv.Itoa(value.Key.(int))
		fileX.WriteString(length + "\n")
		fileY.WriteString(compare + "\n")
	}
}
