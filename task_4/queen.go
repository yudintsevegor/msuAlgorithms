package main

import (
	"fmt"
	"reflect"
)

var a = make([]bool, 8)
var b = make([]bool, 15)
var c = make([]bool, 15)
var x = make([]int, 8)
var m int
var n int

/*
func SetQueen(i,j int){
	x[i] = j
	a[j] = false
	b[i + j] = false
	c[i - j] = false
}

func RemoveQueen(i,j int) {
	j = x[i]
	a[j] = true
	b[i + j] = true
	c[i - j] = true
	x[i] = 0
}

func Safe(i,j int) bool{
	return a[j] && b[i +j] && c[i - j]
}
*/

var result = make(map[int][]int, 1)
var combinations = make(map[int][]int, 1)
var count int

func Try(i int) {
	var j int
	if i < 8 {
		for j = 0; j < 8; j++ {
			if a[j] && b[i+j] && c[i-j+7] {
				x[i] = j
				a[j] = false
				b[i+j] = false
				c[i-j+7] = false
				n++
				Try(i + 1)
				x[i] = -1
				a[j] = true
				b[i+j] = true
				c[i-j+7] = true
			}
		}
	} else {
		/**
		if m < 12 {
			fmt.Println(fmt.Sprint(x))
		}/**/

		combinations[count] = x
		count++

		ansRotate90 := rotate90(x)
		ok1 := check(ansRotate90, combinations)
		if ok1 {
			combinations[count] = ansRotate90
			count++
		}
		ansRotate180 := rotate180(x)
		ok2 := check(ansRotate180, combinations)
		if ok2 {
			combinations[count] = ansRotate180
			count++
		}
		ansRotate270 := rotate270(x)
		ok3 := check(ansRotate270, combinations)
		if ok3 {
			combinations[count] = ansRotate270
			count++
		}
		ansHorizontal := horizontalReflection(x)
		ok4 := check(ansHorizontal, combinations)
		if ok4 {
			combinations[count] = ansHorizontal
			count++
		}
		ansVertical := verticalReflection(x)
		ok5 := check(ansVertical, combinations)
		if ok5 {
			combinations[count] = ansVertical
			count++
		}

		/**/
		//if m < 12 {
		fmt.Println("M", m)
		fmt.Println(x)
		fmt.Println(ansRotate90)
		fmt.Println(ansRotate180)
		fmt.Println(ansRotate270)
		fmt.Println(ansHorizontal)
		fmt.Println(ansVertical)
		/**/
		fmt.Println(ok1)
		fmt.Println(ok2)
		fmt.Println(ok3)
		fmt.Println(ok4)
		fmt.Println(ok5)
		//}
		/**/
		if ok1 && ok2 && ok3 && ok4 && ok5 {
			fmt.Println("X", m)
			result[m] = x
			fmt.Println(fmt.Sprint(x))
		}
		m++
	}
	/**/
}
func check(in []int, mapka map[int][]int) bool {
	for _, value := range mapka {
		if reflect.DeepEqual(in, value) {
			return false
		}
	}
	return true
}

func rotate90(in []int) []int {
	lenth := len(in) - 1
	out := make([]int, lenth+1)
	for ind, value := range in {
		out[lenth-value] = ind
	}
	return out
}

func rotate180(in []int) []int {
	lenth := len(in) - 1
	out := make([]int, lenth+1)
	for ind, value := range in {
		out[lenth-ind] = lenth - value
	}
	return out

}

func rotate270(in []int) []int {
	lenth := len(in) - 1
	out := make([]int, lenth+1)
	for ind, value := range in {
		out[value] = lenth - ind
	}
	return out
}

func verticalReflection(in []int) []int {
	lenth := len(in) - 1
	out := make([]int, lenth+1)
	for ind, value := range in {
		out[ind] = lenth - value
	}
	return out

}

func horizontalReflection(in []int) []int {
	lenth := len(in) - 1
	out := make([]int, lenth+1)
	for ind, value := range in {
		out[lenth-ind] = value
	}
	return out

}

func main() {
	var i int
	var j int
	for i = 0; i < 8; i++ {
		a[i] = true
		x[i] = -1
	}
	for j = 0; j < 15; j++ {
		b[j] = true
		c[j] = true
	}
	m = 0
	n = 0
	count = 0
	Try(0)
	fmt.Println("M", m)
	fmt.Println("N", n)
	fmt.Println(len(result))
	//fmt.Println(combinations[1])
	//for key, value := range result{
	//	fmt.Println(key, value)
	//}
}
