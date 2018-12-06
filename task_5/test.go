package main

import (
	"fmt"
)

type avlNode struct {
	Key            int
	Height         int
	Counter	int
	Left, Right *avlNode
}

func LL(root *avlNode) *avlNode {
	node := root.Right
	root.Right = node.Left
	node.Left = root

	root.Height = max(height(root.Left), height(root.Right)) + 1
	node.Height = max(height(node.Right), height(node.Left)) + 1
	return node
}

func LR(root *avlNode) *avlNode {
	root.Left = LL(root.Left)
	root = RR(root)

	return  root
}

func RR(root *avlNode) *avlNode {
	node := root.Left
	root.Left = node.Right
	node.Right = root

	root.Height = max(height(root.Left), height(root.Right)) + 1
	node.Height = max(height(node.Left), height(node.Right)) + 1
	return node
}

func RL(root *avlNode) *avlNode {
	root.Right = RR(root.Right)
	root = LL(root)

	return  root
}

func height(root *avlNode) int {
	if root != nil {
		return root.Height
	}
	return -1
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func search(root *avlNode, key int) *avlNode {
	if root == nil {
		root = &avlNode{key, 0, 1, nil, nil}
		root.Height = max(height(root.Left), height(root.Right)) + 1
		return root
	}
	if key < root.Key {
		root.Left = search(root.Left, key)
		if height(root.Left)-height(root.Right) == 2 {
			if key < root.Left.Key {
				root = RR(root)
			} else {
				root = LR(root)
			}
		}
	}
	if key > root.Key {
		root.Right = search(root.Right, key)
		if height(root.Right)-height(root.Left) == 2 {
			if key > root.Right.Key {
				root = LL(root)
			} else {
				root = RL(root)
			}
		}
	}

	if key == root.Key {
		root.Counter++
		return root
	}
	root.Height = max(height(root.Left), height(root.Right)) + 1
	return root
}

func showMe(t *avlNode, h int){
	if t == nil {
		return
	}
	format := ""
	for i := 0; i < h; i++{
		format += "{        }"
	}
	format += "---["
	h++
	showMe(t.Right, h)
	//fmt.Printf(format + "VALUE: %v : COUNT: %v\n", t.Value, t.Counter)
	fmt.Printf(format + "VALUE: %v : Counter: %v\n", t.Key, t.Counter)
	showMe(t.Left, h)
}

func main() {
	var root *avlNode
	keys := []int{4,5,10,2,1,3,6,7,7}
	//keys := []int{4,5,10,2,1,3,6,7,7,8}
	//keys := []int{2, 6, 1, 3, 5, 7, 16, 15, 14, 13, 12, 11, 8, 9, 10}
	for _, key := range keys {
		root = search(root, key)
	}

	showMe(root, 0)
}
