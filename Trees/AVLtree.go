package main

import (
	"fmt"
	"strconv"
	/**/
	"bufio"
	"io/ioutil"
	"os"
	"strings"
	/**/)

type Node struct {
	Left    *Node
	Right   *Node
	Value   string
	Counter int
	Balance int
}

func newNode(val string) *Node {
	return &Node{nil, nil, val, 1, 0}
}

func LL(t, t1 *Node) *Node {
	t.Left = t1.Right
	t1.Right = t
	t.Balance = 0
	t = t1
	return t
}

func RR(t, t1 *Node) *Node {
	t.Right = t1.Left
	t1.Left = t
	t.Balance = 0
	t = t1
	return t
}

func LR(t, t1 *Node) *Node {
	t2 := t1.Right
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

func RL(t, t1 *Node) *Node {
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

func search(t *Node, word string, h *bool) *Node {
	if t == nil {
		length++
		mapLengthCompare[length] = compare
		*h = true
		compare = 0
		return newNode(word)
	}
	if word == t.Value {
		t.Counter++
		compare++
		mapLengthCompare[length] = compare
		compare = 0
		return t
	}
	if t.Value > word {
		compare++
		t.Left = search(t.Left, word, &*h)
		if *h { //balance L
			switch t.Balance {
			case 1:
				t.Balance = 0
				*h = false
				break
			case 0:
				t.Balance = -1
				break
			case -1:
				t1 := t.Left
				if t1.Balance == -1 {
					t = LL(t, t1)
				} else {
					t = LR(t, t1)
				}
				t.Balance = 0
				*h = false
				break
			}
		}
		return t
		//} else if t.Value < word {
	} else {
		compare++
		t.Right = search(t.Right, word, &*h)
		if *h { //balance R
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
				if t1.Balance == 1 {
					t = RR(t, t1)
				} else {
					t = RL(t, t1)
				}
				t.Balance = 0
				*h = false
				break
			}
		}
		return t
	}
}

func main() {
	var tree *Node
	/**/
	txt := "text_eng.txt"
	X := "./points/lengthAVL.txt"
	Y := "./points/compareAVL.txt"
	//txt := "text.txt"
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

		h := false
		tree = search(tree, newWord, &h)
	}
	/**/

	//array := []string{"ledas", "lol","ds","ds", "ledas", "safs","wefwef", "ds", "kek", "arbi", "shrek", "shrek", "tyu", "shrek", "shrek", "tyu", "wer", "lol","wer", "qw"}
	/*for _, val := range array{
		h := false
		tree = search(tree, val, &h)
	}
	/**/
	findTop(tree)
	//showMe(tree, 0)
	//fmt.Println(mapLengthCompare)

	sortedTopWords := sortStructByValue(topWords)
	for ind, val := range sortedTopWords {
		fmt.Printf("IND: %v, WORD: %v, COUNT: %v\n", ind, val.Key, val.Value)
	}
	/**/
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
	/**/
	sortedLengthCompare := sortStructByKey(mapLengthCompare)

	for _, value := range sortedLengthCompare {
		compare := strconv.Itoa(value.Value.(int))
		length := strconv.Itoa(value.Key.(int))

		fileX.WriteString(length + "\n")
		fileY.WriteString(compare + "\n")
	}

}
