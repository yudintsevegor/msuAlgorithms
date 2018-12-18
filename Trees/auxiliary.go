package main

import (
	"fmt"
	"sort"
	"strings"
)

type KeyValue struct {
	Key   interface{}
	Value interface{}
}

var length int
var compare int
var mapLengthCompare = make(map[int]int, 1)
var size = 50
var topWords = make(map[string]int, size)

var punctuationMark = map[string]string{
	".":    "",
	",":    "",
	":":    "",
	";":    "",
	"-":    "",
	"\"":   "",
	"*":    "",
	")":    "",
	"(":    "",
	"”":    "",
	"“":    "",
	"...":  "",
	"....": "",
	"!":    "",
	"?":    "",
	"’s":   "",
	"n’t":  "",
	"’re":  "",
}
var punctuation = ". & , & : & ; & - & \" & * & ) & ( & “ & ” & ... & ? & !"

func TextParsing(symbol string) (string, bool) {
	if !strings.ContainsAny(symbol, punctuation) {
		return symbol, true
	}
	if _, ok := punctuationMark[symbol]; ok {
		return symbol, false
	}
	newWord := symbol

	for char, _ := range punctuationMark {
		tmp := strings.Split(newWord, "")
		if strings.HasPrefix(newWord, char) {
			newWord = strings.Join(tmp[1:len(tmp)], "")
			newWord, _ = TextParsing(newWord)
			continue
		}
		if strings.HasSuffix(newWord, char) {
			switch char {
			case "....":
				newWord = strings.Join(tmp[:len(tmp)-4], "")
				newWord, _ = TextParsing(newWord)
				return newWord, true
				continue
			case "...", "’re", "n’t":
				newWord = strings.Join(tmp[:len(tmp)-3], "")
				newWord, _ = TextParsing(newWord)
				return newWord, true
				continue
			case "’s":
				newWord = strings.Join(tmp[:len(tmp)-2], "")
				newWord, _ = TextParsing(newWord)
				return newWord, true
				continue
			default:
				newWord = strings.Join(tmp[:len(tmp)-1], "")
				newWord, _ = TextParsing(newWord)
				return newWord, true
				continue
			}
		}
	}
	return newWord, true
}

func sortTopWords(topWords map[string]int, t *Node) map[string]int {
	result := make(map[string]int, size+1)

	if len(topWords) <= size {
		return topWords
	}

	sortedTopWords := sortStructByValue(topWords)

	for ind, val := range sortedTopWords {
		if ind < size {
			result[val.Key.(string)] = val.Value.(int)
			continue
		}
	}

	return result
}

func sortStructByKey(topWords map[int]int) []KeyValue {
	var sortedTopWords = make([]KeyValue, 0, size+1)
	for key, value := range topWords {
		sortedTopWords = append(sortedTopWords, KeyValue{key, value})
	}
	sort.Slice(sortedTopWords, func(i, j int) bool {
		return sortedTopWords[i].Key.(int) < sortedTopWords[j].Key.(int)
	})

	return sortedTopWords
}

func sortStructByValue(topWords map[string]int) []KeyValue {
	var sortedTopWords = make([]KeyValue, 0, size+1)
	for key, value := range topWords {
		sortedTopWords = append(sortedTopWords, KeyValue{key, value})
	}
	sort.Slice(sortedTopWords, func(i, j int) bool {
		return sortedTopWords[i].Value.(int) > sortedTopWords[j].Value.(int)
	})

	return sortedTopWords
}

func findTop(t *Node) {
	if t == nil {
		return
	}
	findTop(t.Right)
	if len(topWords) <= size {
		topWords[t.Value] = t.Counter
	}
	topWords = sortTopWords(topWords, t)
	findTop(t.Left)
}

func showMe(t *Node, h int) {
	if t == nil {
		return
	}
	format := ""
	for i := 0; i < h; i++ {
		format += "{        }"
	}
	format += "---["
	h++
	showMe(t.Right, h)
	fmt.Printf(format+"%v : %v\n", t.Value, t.Counter)
	//fmt.Printf(format + "VALUE: %v\n", t.Value)
	showMe(t.Left, h)
}
