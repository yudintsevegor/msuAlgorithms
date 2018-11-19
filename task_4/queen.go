package main

import (
	"fmt"
	"reflect"
)

var notQueenAtRow = make([]bool, 0, 1)
var notQueenAtDiagonalI = make([]bool, 0, 1)
var notQueenAtDiagonalII = make([]bool, 0, 1)
var x = make([]int, 0, 1)
var m int
var n int

var result = make(map[int][]int, 1)
var combinations = make(map[int][]int, 1)
var count int

func Try(i int, sizeOfChessBoard int ){
	var j int
	//fmt.Println(result)
	if i < sizeOfChessBoard {
		for j = 0; j < sizeOfChessBoard; j++ {
			if notQueenAtRow[j] && notQueenAtDiagonalI[i + j] && notQueenAtDiagonalII[i - j + (sizeOfChessBoard - 1)] {
				x[i] = j
				notQueenAtRow[j] = false
				notQueenAtDiagonalI[i + j] = false
				notQueenAtDiagonalII[i - j + (sizeOfChessBoard - 1)] = false
				n++
				Try(i + 1, sizeOfChessBoard)
				x[i] = -1
				notQueenAtRow[j] = true
				notQueenAtDiagonalI[i + j] = true
				notQueenAtDiagonalII[i -j + (sizeOfChessBoard - 1)] = true
			}
		}
	} else {
		element := x
		fmt.Println(m, element, result)

		combinations[count] = element
		count++
		/**/
		if m == 0 {
			fmt.Println("LOl")
			result[m] = element
		}
		/**/
		ansRotate90 := rotate90(element)
		ok1 := check(ansRotate90, combinations)
		if ok1 {
			combinations[count] = ansRotate90
			count++
		}
		ansRotate180 := rotate180(element)
		ok2 := check(ansRotate180, combinations)
		if ok2 {
			combinations[count] = ansRotate180
			count++
		}
		ansRotate270 := rotate270(element)
		ok3 := check(ansRotate270, combinations)
		if ok3 {
			combinations[count] = ansRotate270
			count++
		}
		ansHorizontal := horizontalReflection(element)
		ok4 := check(ansHorizontal, combinations)
		if ok4 {
			combinations[count] = ansHorizontal
			count++
		}
		ansVertical := verticalReflection(element)
		ok5 := check(ansVertical, combinations)
		if ok5 {
			combinations[count] = ansVertical
			count++
		}

		/**/
		//if m < 12 {
		fmt.Println("M", m)
		fmt.Println(element)
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
			result[m] = element
			fmt.Println(fmt.Sprint(element))
		}
		//fmt.Println(fmt.Sprint(x))
		//fmt.Println(result)
		fmt.Println(m, element, result)
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
	out := make([]int, lenth + 1)
	for ind, value := range in {
		out[value] = lenth - ind
	}
	return out
}

func verticalReflection(in []int) []int {
	lenth := len(in) - 1
	out := make([]int, lenth + 1)
	for ind, value := range in {
		out[ind] = lenth - value
	}
	return out

}

func horizontalReflection(in []int) []int {
	lenth := len(in) - 1
	out := make([]int, lenth + 1)
	for ind, value := range in {
		out[lenth-ind] = value
	}
	return out

}

func main() {
	var i int
	var j int
	sizeOfChessBoard := 4
	for i = 0; i < sizeOfChessBoard; i++ {
		//notQueenAtRow[i] = true
		notQueenAtRow = append(notQueenAtRow, true)
		x = append(x, -1)
		//x[i] = -1
	}
	for j = 0; j < ( sizeOfChessBoard * 2 ) - 1 ; j++ {
		//notQueenAtDiagonalI[j] = true
		//notQueenAtDiagonalII[j] = true
		notQueenAtDiagonalI = append(notQueenAtDiagonalI, true)
		notQueenAtDiagonalII = append(notQueenAtDiagonalII, true)
	}
	m = 0
	n = 0
	count = 0
	Try(0, sizeOfChessBoard)
	fmt.Println("M", m)
	fmt.Println("N", n)
	fmt.Println(len(result))
	//fmt.Println(combinations[1])
	//for key, value := range result{
	//	fmt.Println(key, value)
	//}
}
