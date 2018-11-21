package main

import (
	"fmt"
	//"strings"
)
type BTree struct {
	Left *BTree
	Right *BTree
	Value string
	counter int
}

func push(t *BTree, word string) {


}

func insert(t *BTree, word string) *BTree{
	if t == nil {
		t = &BTree{nil, nil, v, 1}
		return t
	}

	if word < t.Value {
		t.Left = insert(t.Left, word)
	} else {
		t.Right = insert(t.Right, word)
	}
	return t
}

func del() {

}

func find() {

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
	fmt.Printf(format + "%s\n", t.Value)
	showMe(t.Left, h)
}

func main() {
	var tree *BTree
	//fmt.Pritln(tree)
	array := []int{"1", "2", "1", "23", "77", "1", "1", "2", "44"}
	for i := 0; i < len(array); i++{
		tree = insert(tree, array[i])
	}
	showMe(tree, 0)
	//fmt.Println(tree.String())
}


