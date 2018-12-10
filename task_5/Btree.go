package main

import (
	"fmt"
	"strings"
	"strconv"
	/**/
	"io/ioutil"
	"bufio"
	"os"
	/**/
)

type Node struct {
	Left *Node
	Right *Node
	Value string
	Counter int
}

func newNode(val string) *Node{
	return  &Node{nil, nil, val, 1}
}

func insert(t *Node, word string) *Node{
	if t == nil {
		length++
		mapLengthCompare[length] = compare
		compare = 0
		return newNode(word)
	}
	switch strings.Compare(word, t.Value){
	case 1:
		compare++
		t.Right = insert(t.Right, word)
		return t
	case -1:
		compare++
		t.Left = insert(t.Left, word)
		return t
	default: //==0
		t.Counter++
		compare++
		mapLengthCompare[length] = compare
		compare = 0
		return t
	}
}

func main() {
	var tree *Node
	/**/
	txt := "text_eng.txt"
	//txt := "text.txt"
	file, err := ioutil.ReadFile(txt)
	if err != nil {
		fmt.Println(err)
	}
	content := string(file)
	scanner := bufio.NewScanner(strings.NewReader(content))
	scanner.Split(bufio.ScanWords)
	for scanner.Scan(){
		tree = insert(tree, scanner.Text())
	}
	/**
	//array := []string{"ledas", "lol","ds","ds", "ledas", "safs","wefwef", "ds", "kek", "arbi", "shrek", "shrek", "tyu", "shrek", "shrek", "tyu", "wer", "lol","wer", "qw"}
	array := []string{"4", "5","7","2", "1", "3","6","1"}
	for _, val := range array{
		tree = insert(tree, val)
	}
	showMe(tree, 0)
	/**/
	findTop(tree)

	sortedTopWords := sortStructByValue(topWords)
	/**/
	for ind, val := range sortedTopWords {
		fmt.Printf("IND: %v, WORD: %v, COUNT: %v\n", ind, val.Key, val.Value)
	}
	/**/
	X := "./points/lengthBT.txt"
	Y := "./points/compareBT.txt"
	fileX, err := os.Create(X)
	defer fileX.Close()
	if err != nil{
		fmt.Println(err)
	}
	fileY, err := os.Create(Y)
	defer fileY.Close()
	if err != nil{
		fmt.Println(err)
	}
	/**/
	sortedLengthCompare := sortStructByKey(mapLengthCompare)

	for _, value := range sortedLengthCompare{
		compare := strconv.Itoa(value.Value.(int))
		length := strconv.Itoa(value.Key.(int))
		//fmt.Println(value.Key, compare)
		fileX.WriteString(length + "\n")
		fileY.WriteString(compare + "\n")
	}
}

