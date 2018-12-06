package main

import (
	"fmt"
	/*"io/ioutil"
	"bufio"
	"sort"
	"os"
	"strings"
	"strconv"
	*/
)


type KeyValue struct {
	Key string
	Value int
}

type AVLtree struct {
	Root *Node
}

type Node struct {
	Left *Node
	Right *Node
	Value int
	Counter int
	Balance int
}

var length int
var compare int
var mapLengthSwap = make(map[int]int, 1)
var size = 50
var topWords = make(map[string]int, size + 1)


func newNode(val int) *Node{
	return  &Node{nil, nil, val, 1, 0}
}

func LL(t, t1 *Node) *Node{
	//fmt.Println("LLLLLLLLlLLLLLLLLLLLL")
	t.Left = t1.Right
	t1.Right = t
	t.Balance = 0
	t = t1
	return  t
}

func RR(t, t1 *Node) *Node{
	//fmt.Println("RRRRRRRRRRRRRRRRRRRRRRRRRRR")
	t.Right = t1.Left
	t1.Left = t
	t.Balance = 0
	t = t1
	return t
}

func LR(t, t1 *Node) *Node{
	//fmt.Println("LLLLLLLLLLLLLLLRRRRRRRRRR")
	t2 := t1.Right
/*
	fmt.Println("T1")
	fmt.Println(t1)
	fmt.Println("T2")
	fmt.Println(t2)
	*/
	t1.Right = t2.Left
	t2.Left = t1
	t.Left = t2.Right
	t2.Right = t
	if t2.Balance == -1 {
		t.Balance = 1
	} else {
		t.Balance = 0
	}
	if t2.Balance == 1 {
		t1.Balance = -1
	} else {
		t1.Balance = 0
	}
	t = t2
	return t
}

func RL(t, t1 *Node) *Node{
	//fmt.Println("RRRRRRRRRRRRRRRRRLLLLLLLLLLL")
	t2 := t1.Left
	t1.Left = t2.Right
	t2.Right = t1
	t.Right = t2.Left
	t2.Left = t
	if t2.Balance == 1 {
		t.Balance = -1
	} else {
		t.Balance = 0
	}
	if t2.Balance == -1 {
		t1.Balance = 1
	} else {
		t1.Balance = 0
	}
	t = t2
	return t
}

func search(t *Node, word int, h *bool) *Node{
	//fmt.Println(t)
	//showMe(t, 0)
	//fmt.Println(*h)
	//fmt.Println(word)
	if t == nil {
	//	fmt.Println(word)
		//fmt.Println("NIL: ", t)
		length++
		mapLengthSwap[length] = compare
		*h = true
		//fmt.Println("NULL")
		//fmt.Println(word)
		//showMe(t, 0)
		//fmt.Println("==========================================")
		return newNode(word)
	}
	if  t.Value == word {
		t.Counter++
		compare++
		return t
	}
	if  t.Value > word {
		//fmt.Println(" > ")
		//fmt.Println("LEFT BEF", t.Left)
		t.Left = search(t.Left, word, &*h)
		//fmt.Println("LEFT AF", t.Left)
		if *h { //balance L
			//fmt.Println("BEFORE SWITCH")
			//fmt.Println(word, t)
			switch t.Balance{
			case 1:
				t.Balance = 0
				*h = false
				break
			case 0:
				t.Balance = -1
				break
			case -1:
				t1 := t.Left
				/*fmt.Println("t")
				fmt.Println(t)
				fmt.Println("t1")
				fmt.Println(t1)
				//if t1.Left == nil && t1.Right == nil && t1.Counter > 1 {
				//if t1.Left == nil && t1.Right == nil {
				//	fmt.Println("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA")
					//t1.Balance = 0
				//	return t
				//}
				*/
				//fmt.Println("HAHA")
				fmt.Println(word, t)
				fmt.Println(word, t1)
				if t1.Balance == -1 {
					t = LL(t,t1)
				} else {
					t = LR(t,t1)
				}
				t.Balance = 0
				*h = false
				break
			}
		}
		//fmt.Println("L")
		/*fmt.Println("AFTER SWITCH")
		fmt.Println(word, t)

		showMe(t, 0)
		fmt.Println("==========================================")
		*/
		compare++
		return t
	} else if t.Value < word {
		t.Right = search(t.Right, word, &*h)
		if *h { //balance R
		//fmt.Println("R")
			switch t.Balance {
			case -1:
				t.Balance = 0
				*h = false
				break
			case 0:
				t.Balance = 1
				break
			case 1:
				t1 := t.Right
				//if t1.Left == nil && t1.Right == nil && t1.Counter > 1 {
				//	break
				//}
				/*fmt.Println("t")
				fmt.Println(t)
				fmt.Println("t1")
				fmt.Println(t1)
				*/
				if t1.Balance == 1{
					t = RR(t,t1)
				} else {
					t = RL(t,t1)
				}
				t.Balance = 0
				*h = false
				break
			}
		}
		compare++
		/*fmt.Println("R")
		//fmt.Println(word)
		showMe(t, 0)
		fmt.Println("==========================================")
		*/
		return t
	}
	//fmt.Println("LOL")
	//length++
	//mapLengthSwap[length] = compare
	//compare = 0
	return t
}

var min int
var minKey string
/*
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
*/
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
	fmt.Printf(format + "VALUE: %v : COUNT: %v\n", t.Value, t.Counter)
	//fmt.Printf(format + "VALUE: %v\n", t.Value)
	showMe(t.Left, h)
}

func main() {
	var tree *Node
	/*
	txt := "text_eng.txt"
	X := "./points/lengthBtree.txt"
	Y := "./points/compareBtree.txt"
	//txt := "text.txt"
	file, err := ioutil.ReadFile(txt)
	if err != nil {
		fmt.Println(err)
	}
	content := string(file)
	scanner := bufio.NewScanner(strings.NewReader(content))
	scanner.Split(bufio.ScanWords)
	for scanner.Scan(){
		tree = search(tree, scanner.Text())
	}
	*/

	//array := []int{4,5,7,2,1,3,6,45, 23,2,11,3,4, 4, 4, 4,1,23,44,5,3,8,9,2121,323,4}
	//array := []int{4,5,10,2,1,3,6,7,7,8}
//	array := []int{4,5,7, 2, 1, 3, 6}
	array := []int{4,5,10,2,1,3,6,7,7}
	//array := []int{4,5,10,2,1,3,6,7,7, 8}
	//array := []int{4,3,2, 1,}
	//array := []int{8, 4, 10, 2, 6 ,1 ,3 ,5, 7 ,9}
	//array := []string{"ledas", "lol","ds","ds", "ledas", "safs","wefwef", "ds", "kek", "arbi", "shrek", "shrek", "tyu", "tyu", "wer", "lol","wer", "qw"}
	for _, val := range array{
		//fmt.Println(val)
		h := false
		tree = search(tree, val, &h)
	}

	//findTop(tree)
	showMe(tree, 0)
	fmt.Println(mapLengthSwap)
	/*sortedStruct := make([]KeyValue, size + 1)

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
		compare := strconv.Itoa(value)

		fileX.WriteString(length + "\n")
		fileY.WriteString(compare + "\n")
	}
	*/
}

