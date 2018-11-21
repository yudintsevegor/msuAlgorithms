package main

import (
	"fmt"
	"reflect"
	"os"
	"strconv"
)

var notQueenAtRow = make([]bool, 0, 1)
var notQueenAtDiagonalI = make([]bool, 0, 1)
var notQueenAtDiagonalII = make([]bool, 0, 1)
var x = make([]int, 0, 1)
var positionsAll int
var recursiveCalls int

var result = make(map[int][]int, 1)
var combinations = make(map[int][]int, 1)
var count int

func Try(i int, sizeOfChessBoard int) {
	var j int
	if i < sizeOfChessBoard {
		for j = 0; j < sizeOfChessBoard; j++ {
			if notQueenAtRow[j] && notQueenAtDiagonalI[i+j] && notQueenAtDiagonalII[i-j+(sizeOfChessBoard-1)] {
				x[i] = j
				notQueenAtRow[j] = false
				notQueenAtDiagonalI[i+j] = false
				notQueenAtDiagonalII[i-j+(sizeOfChessBoard-1)] = false
				recursiveCalls++
				Try(i+1, sizeOfChessBoard)

				x[i] = -1
				notQueenAtRow[j] = true
				notQueenAtDiagonalI[i+j] = true
				notQueenAtDiagonalII[i-j+(sizeOfChessBoard-1)] = true
			}
		}
	} else {
		helper := make([]int, sizeOfChessBoard)
		copy(helper, x)

		combinations[count] = helper
		count++

		if positionsAll == 0 {
			result[positionsAll] = helper
		}

		ansRotate90 := rotate90(helper)
		ok1 := check(ansRotate90, combinations)
		if ok1 {
			combinations[count] = ansRotate90
			count++
		}
		ansRotate180 := rotate180(helper)
		ok2 := check(ansRotate180, combinations)
		if ok2 {
			combinations[count] = ansRotate180
			count++
		}
		ansRotate270 := rotate270(helper)
		ok3 := check(ansRotate270, combinations)
		if ok3 {
			combinations[count] = ansRotate270
			count++
		}
		ansHorizontal := horizontalReflection(helper)
		ok4 := check(ansHorizontal, combinations)
		if ok4 {
			combinations[count] = ansHorizontal
			count++
		}
		ansVertical := verticalReflection(helper)
		ok5 := check(ansVertical, combinations)
		if ok5 {
			combinations[count] = ansVertical
			count++
		}

		if ok1 && ok2 && ok3 && ok4 && ok5 {
			result[positionsAll] = helper
		}
		positionsAll++
	}
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
	out := make([]int, lenth + 1)
	for ind, value := range in {
		out[lenth-value] = ind
	}
	return out
}

func rotate180(in []int) []int {
	lenth := len(in) - 1
	out := make([]int, lenth + 1)
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

func showPositions(data  []int){
	lenth := len(data)
	fmt.Printf("CHESSBOARD %v x %v\n", lenth, lenth)
	var numbers = make([]string, 0 , lenth + 1)
	numbers = append(numbers, "$$")
		for i := 0; i < len(data); i++{
		var board = make([]string, 0, lenth + 1)
		board = append(board, strconv.Itoa(lenth- 1) + " ")
		for j := 0; j < len(data); j++{
			if data[j] == lenth - 1{
				board = append(board, "* ")
			} else {
				board = append(board, "_ ")
			}
		}
		lenth--
		fmt.Println(fmt.Sprint(board))
	}

	for k := 0; k < len(data); k++{
		numbers = append(numbers, strconv.Itoa(k) + " ")
	}
	fmt.Println(fmt.Sprint(numbers))

}

func main() {
	var i int
	var j int
	var pointsAll = make([]int, 0, 1)
	var pointsUniq = make([]int, 0, 1)
	var pointsCalls = make([]int, 0, 1)
	var pointsChessBoard =  make([]int, 0, 1)
	sizeOfChessBoard := 10

	for size := 2; size <= sizeOfChessBoard; size++ {
		for i = 0; i < size; i++ {
			notQueenAtRow = append(notQueenAtRow, true)
			x = append(x, -1)
		}
		for j = 0; j < (size*2)-1; j++ {
			notQueenAtDiagonalI = append(notQueenAtDiagonalI, true)
			notQueenAtDiagonalII = append(notQueenAtDiagonalII, true)
		}
		positionsAll = 0
		recursiveCalls = 0
		count = 0
		Try(0, size)
		positionsUniq := len(result)

		fmt.Println("RESULT")
		fmt.Println(result[0])
		showPositions(result[0])

		pointsAll = append(pointsAll, positionsAll)
		pointsUniq = append(pointsUniq, positionsUniq)
		pointsCalls = append(pointsCalls, recursiveCalls)
		pointsChessBoard = append(pointsChessBoard, size)
	}
	fmt.Println("All: ")
	fmt.Println(fmt.Sprint(pointsAll))
	fmt.Println("Uniq: ")
	fmt.Println(fmt.Sprint(pointsUniq))
	fmt.Println("Calls: ")
	fmt.Println(fmt.Sprint(pointsCalls))
	fmt.Println("Size of ChessBoard: ")
	fmt.Println(fmt.Sprint(pointsChessBoard))

	fAll, _ := os.Create("./points/pointsAll.txt")
	fUniq, _ := os.Create("./points/pointsUniq.txt")
	fCalls, _ := os.Create("./points/pointsCalls.txt")
	fSize, _ := os.Create("./points/pointsSize.txt")

	defer fAll.Close()
	defer fUniq.Close()
	defer fCalls.Close()
	defer fSize.Close()

	for ind, _ := range  pointsChessBoard{
		strAll := strconv.Itoa(pointsAll[ind])
		strUniq := strconv.Itoa(pointsUniq[ind])
		strCalls := strconv.Itoa(pointsCalls[ind])
		strSize := strconv.Itoa(pointsChessBoard[ind])

		fAll.WriteString(strAll + "\n")
		fUniq.WriteString(strUniq + "\n")
		fCalls.WriteString(strCalls + "\n")
		fSize.WriteString(strSize + "\n")
	}
}




