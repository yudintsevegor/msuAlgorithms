package main

import (
	"container/list"
	"crypto/md5"
	"fmt"
	"io"
	_ "reflect"
	"strconv"
	"strings"
)

const (
	N = 20000
)

var hTableMD5 = make([]list.List, N)

//var hTableMD5 [N]list.List
var hTableMFC = make([]list.List, N)

//var hTableMFC [N]list.List

var collisionsMFC int
var collisionsMD5 int
var notEmptyMFC int
var notEmptyMD5 int

func cutHexValue(str string) string {
	tmp := strings.Split(str, "")
	outString := strings.Join(tmp[:len(tmp)/2], "")

	return outString
}

func MD5Hash(word string) uint64 {
	hasher := md5.New()
	io.WriteString(hasher, word)
	md5Hash := hasher.Sum(nil)
	res := fmt.Sprintf("%x", md5Hash)
	res = cutHexValue(res)
	result, _ := strconv.ParseUint(res, 16, 64)

	return result
}

func MFCHash(word string) uint64 {
	var nHash rune
	letters := strings.Split(word, "")
	for _, value := range letters {
		nHash = (nHash << 5) + nHash + []rune(value)[0]
	}

	return uint64(nHash)
}

func insert(word string, index uint64) {

}

func main() {
	/*
		txt := "EngText.txt"
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
	array := []string{"ledas", "lol", "ds"}
	var lst list.List
	for _, value := range array {
		fmt.Println("VALUE: ", value)

		res := MFCHash(value)
		fmt.Println("RESULT FROM MFC: ", res)

		res_1 := MD5Hash(value)
		fmt.Println("RESULT FROM MD5 :", res_1)

		lst.PushBack(value)
		hTableMFC[res%N] = lst
		fmt.Println(res % N)
		//hTableMD5[res_1] = lst
		//hTableMFC = append(hTableMFC, lst)
	}
	//fmt.Println(hTableMFC[1].Front().Next().Value)
	//fmt.Println(hTableMFC[1].Back().Value)
	fmt.Println(hTableMFC[1321])
	fmt.Println(hTableMFC[0])
	//for i := 0; i < reflect.ValueOf(hTable[0]).NumField(); i++ {
	//	fmt.Println(reflect.ValueOf(hTable[0]).Type().Field(i).Name)
	//}
}
