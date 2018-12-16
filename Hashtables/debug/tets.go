package main

import (
   	"crypto/md5"
    	"encoding/hex"
	"fmt"
)

func GetMD5Hash(text string) string {
    hasher := md5.New()
    hasher.Write([]byte(text))
    return hex.EncodeToString(hasher.Sum(nil))
}


func main() {
	test := "lol"
	res := GetMD5Hash(test)
	fmt.Println(res)
}
