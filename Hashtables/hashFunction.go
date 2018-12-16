package main

import (
	"fmt"
	"crypto/md5"
	"strconv"
	"io"
	"strings"
	"container/list"
	_"reflect"
)

const (
	N = 20000
)

var hTable = make([]list.List, 0, N)

func cutHexValue(str string) (string){
	tmp := strings.Split(str, "")
	outString := strings.Join(tmp[:len(tmp)/2], "")

	return outString
}

func MD5Hash(word string) uint64 {
	hasher := md5.New()
	io.WriteString(hasher, word)
	md5Hash := hasher.Sum(nil)
	res := fmt.Sprintf("%x",md5Hash)
	res = cutHexValue(res)
	result, _ := strconv.ParseUint(res, 16, 64)

	return result
}

func MFCHash(word string) rune {
	var nHash rune
	letters := strings.Split(word, "")
	for _, value := range letters{
		nHash = ( nHash << 5 ) + nHash + []rune(value)[0]
	}

	return nHash
}

func main(){
	/*
	txt := "text_eng.txt"
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
		if !isOk{
			continue
		}
		newWord = strings.ToLower(newWord)
		tree = insert(tree, newWord)
	}
	/**/
	//array := []string{"ledas", "lol","ds","ds", "ledas", "safs","wefwef", "ds", "kek", "arbi", "shrek", "shrek", "tyu", "shrek", "shrek", "tyu", "wer", "lol","wer", "qw"}
	array := []string{"ledas", "lol","ds"}
	var lst list.List
	for _, value := range array {
		fmt.Println("VALUE: ",value)
		res := MFCHash(value)
		fmt.Println("RESULT FROM MFC: ",res)
		res_1 := MD5Hash(value)
		lst.PushBack(res_1)
		fmt.Println("RESULT FROM MD5 :", res_1)
		lst.PushBack(res)
		hTable = append(hTable, lst)
	}
	fmt.Println(hTable[1].Front().Next().Value)
	fmt.Println(hTable[1].Back().Value)
	//for i := 0; i < reflect.ValueOf(hTable[0]).NumField(); i++ {
	//	fmt.Println(reflect.ValueOf(hTable[0]).Type().Field(i).Name)
	//}
}
