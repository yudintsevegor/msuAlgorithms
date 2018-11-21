package main

import (
	"fmt"
	//"strings"
)
type BTree struct {
	Left *BTree
	Right *BTree
	Value int
}

func insert(t *BTree, v int) *BTree{
	if t == nil {
		t = &BTree{nil, nil, v}
	} else if v < t.Value {
		t.Left = insert(t.Left, v)
	} else {
		t.Right = insert(t.Right, v)
	}
	return t
}

func showMe(t *BTree, h int){
	if t == nil {
		return
	}
	format := ""
	for i := 0; i < h; i++{
		format += "          "
	}
	format += "---["
	h++
	showMe(t.Right, h)
	fmt.Printf(format + "%d\n", t.Value)
	showMe(t.Left, h)
}

func main() {
	var tree *BTree
	//var num int
	//fmt.Println(num)
	array := []int{8, 4, 2, 1, 3, 6, 5, 7, 10, 9, 11}
	for i := 0; i < len(array); i++{
		tree = insert(tree, array[i])
	}
	showMe(tree, 0)
	//fmt.Println(tree.String())
}


