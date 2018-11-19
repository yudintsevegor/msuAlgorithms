package main

import (
    "fmt"
)

type Node struct{
    Value int
    Left *Node
    Right *Node
}

func insert(root *Node,v int) *Node {
    if root == nil{
        root = &Node{v,nil,nil}
    } else if v<root.Value{
        root.Left = insert(root.Left,v)
    } else{
        root.Right = insert(root.Right,v)
    }
    return root
}

func inTraverse(root *Node){
    if (root==nil){
        return
    }
    inTraverse(root.Left)
    fmt.Printf("%d ",root.Value)
    inTraverse(root.Right)
}

func main() {
    var treeRoot *Node
    a := []int{1, 2, 6, 4, 5}
    for i:=0;i<len(a);i++{
        treeRoot = insert(treeRoot,a[i])
    }
    inTraverse(treeRoot)
}
