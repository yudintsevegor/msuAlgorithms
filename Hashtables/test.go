package main

import (
	"crypto/md5"
	"io"
	//"encoding/hex"
	"fmt"
	"strconv"
	"strings"
)

const (
	N = 20000
)

func cutHexValue(str string) (string){
	tmp := strings.Split(str, "")
	outString := strings.Join(tmp[:len(tmp)/2], "")

	return outString
}
func MD5Hash(word string) uint64{
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

func main() {
	test := "lol"
	//fmt.Println('l')
	//fmt.Println([]rune("l"))
	//fmt.Println([]rune("L"))
	res_1 := MD5Hash(test)
	fmt.Println(res_1)
	fmt.Println(res_1 % 20000)
	res := MFCHash(test)
	fmt.Println(res)
	fmt.Println(res % 20000)
}
