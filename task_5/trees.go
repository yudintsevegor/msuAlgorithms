package main

import (
	"fmt"
	//"strconv"
	//"strings"
)


type Btree struct {
	Root *Node
}

type Node struct {
	Left *Node
	Right *Node
	Value string
	Counter int
}

var length int
var swap int
var mapSwapLength = make(map[int]int, 1)

func newNode(val string) *Node{
	return  &Node{nil, nil, val, 1}
}

func insert(t *Node, word string) *Node{
	if t == nil {
		length++
		mapSwapLength[swap] = length
		//t = &BTree{nil, nil, word, 1}
		return newNode(word)
	}
	if word == t.Value {
		t.Counter++
		swap++
		return t
	} else if  word < t.Value {
		swap++
		t.Left = insert(t.Left, word)
		return t
	} else {
		swap++
		t.Right = insert(t.Right, word)
		return t
	}
	length++
	mapSwapLength[swap] = length
	swap = 0
	return t
}

func showMe(t *Node, h int){
	if t == nil {
		return
	}
	format := ""
	for i := 0; i < h; i++{
		format += "        "
	}
	format += "---["
	h++
	showMe(t.Right, h)
	fmt.Printf(format + "%v : %v\n", t.Value, t.Counter)
	showMe(t.Left, h)
}

func main() {
	var tree *Node
	//fmt.Pritln(tree)
	//array := []string{"1", "2", "1", "23", "77", "1", "1", "2", "44"}
	//array := []int{1, 2, 1, 23, 77, 1, 1, 2, 44}
	//array := []int{8, 4, 10, 2, 6 ,1 ,3 ,5, 7 ,9}
	array := []string{"ledas", "lol", "dw", "safs", "lol","wefwef", "ds"}
	for _, val := range array{
		//str := strconv.Itoa(val)
		tree = insert(tree, val)
	}
	showMe(tree, 0)
	fmt.Println(mapSwapLength)
}


