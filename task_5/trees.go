package main

import (
	"fmt"
	"io/ioutil"
	"bufio"
	"sort"
	"os"
	"strings"
	"strconv"
)


type KeyValue struct {
	Key string
	Value int
}

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
var mapLengthSwap = make(map[int]int, 1)
var size = 50
var topWords = make(map[string]int, size + 1)

func newNode(val string) *Node{
	return  &Node{nil, nil, val, 1}
}

func insert(t *Node, word string) *Node{
	if t == nil {
		length++
		mapLengthSwap[length] = swap
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
	} else if word > t.Value {
		swap++
		t.Right = insert(t.Right, word)
		return t
	}
	length++
	mapLengthSwap[length] = swap
	swap = 0
	return t
}

var min int
var minKey string

func sortMap(topWords map[string]int, t *Node) (map[string]int){
	var ind int
	if len(topWords) <= size {
		return topWords
	}
	result := make(map[string]int, size + 1)
	for key, val := range topWords{
		if ind == 0 {
			min = val
			ind++
			continue
		}
		if min >= val {
			min = val
			minKey = key
		}
		ind++
	}
	if min > t.Counter {
		return topWords
	}
	mark := true
	for key, val := range topWords{
		if min == val && mark == true{
			result[t.Value] = t.Counter
			mark = false
			continue
		}
		result[key] = val
	}
	return result
}

func findTop(t *Node){
	if t == nil {
		return
	}
	findTop(t.Right)
	if len(topWords) <= size{
		topWords[t.Value] = t.Counter
	}
	topWords = sortMap(topWords, t)
	findTop(t.Left)
}

func showMe(t *Node, h int){
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
	fmt.Printf(format + "%v : %v\n", t.Value, t.Counter)
	showMe(t.Left, h)
}

func main() {
	var tree *Node
	txt := "text_eng.txt"
	X := "./points/length.txt"
	Y := "./points/swap.txt"
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
	/*
	//array := []int{1, 2, 1, 23, 77, 1, 1, 2, 44}
	//array := []int{8, 4, 10, 2, 6 ,1 ,3 ,5, 7 ,9}
	array := []string{"ledas", "lol","ds","ds", "ledas", "safs","wefwef", "ds", "kek", "arbi", "shrek", "shrek", "tyu", "tyu", "wer", "lol","wer", "qw"}
	for _, val := range array{
		tree = insert(tree, val)
	}
	*/
	findTop(tree)
	//showMe(tree, 0)
	sortedStruct := make([]KeyValue, size + 1)

	for key, value := range topWords{
		sortedStruct = append(sortedStruct, KeyValue {key, value})
	}

	sort.Slice(sortedStruct, func(i, j int) bool {
		return sortedStruct[i].Value > sortedStruct[j].Value
	})

	ind := 0
	for _, val := range sortedStruct {
		fmt.Printf("IND: %v, WORD: %v, COUNT: %v\n", ind, val.Key, val.Value)
		ind++
	}
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
	for key, value := range mapLengthSwap{
		length := strconv.Itoa(key)
		swap := strconv.Itoa(value)

		fileX.WriteString(length + "\n")
		fileY.WriteString(swap + "\n")
	}
}

