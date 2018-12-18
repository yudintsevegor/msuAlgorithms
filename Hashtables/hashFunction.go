package main

import (
	"bufio"
	"container/list"
	"crypto/md5"
	"fmt"
	"io"
	"io/ioutil"
	"os"
	"strconv"
	"strings"
)

const (
	N = 6599
	//N = 8009
	//N = 5003
	//N = 10007
)

type CollisionOccupancy struct {
	Collision int
	Occupancy float64
}

var collOccMFCSlice = make([]CollisionOccupancy, 1)
var collOccMD5Slice = make([]CollisionOccupancy, 1)

var hTableMFC = make([]list.List, N)
var hTableMD5 = make([]list.List, N)

var collisionsMFC int
var collisionsMD5 int
var notEmptyMFC float64
var notEmptyMD5 float64
var occupancyMFC float64
var occupancyMD5 float64

func cutHexValue(str string) string {
	tmp := strings.Split(str, "")
	outString := strings.Join(tmp[:len(tmp)/4], "")

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

func insertIntoScroll(word string, element *list.Element, scroll list.List) {
	if element.Next() == nil || element.Value == nil {
		var wordCounter = make(map[string]int, 1)
		wordCounter[word] = 1
		scroll.PushBack(wordCounter)
		return
	}
	tmpMap := element.Value.(map[string]int)
	if _, ok := tmpMap[word]; ok {
		tmpMap[word]++
		return
	}

	insertIntoScroll(word, element.Next(), scroll)
}

func insert(word string, index uint64, hashTable []list.List) int {
	var wordCounter = make(map[string]int, 1)
	if hashTable[index].Front() == nil {
		wordCounter[word] = 1
		hashTable[index].PushBack(wordCounter)
		return 0
	}
	element := hashTable[index].Front()
	insertIntoScroll(word, element, hashTable[index])

	return 1
}

func main() {
	/**/
	txt := "EngText.txt"
	file, err := ioutil.ReadFile(txt)
	if err != nil {
		fmt.Println(err)
	}
	content := string(file)
	scanner := bufio.NewScanner(strings.NewReader(content))
	scanner.Split(bufio.ScanWords)

	count := 0
	for scanner.Scan() {
		word := scanner.Text()
		newWord, isOk := TextParsing(word)
		if !isOk {
			continue
		}
		newWord = strings.ToLower(newWord)

		var colOccMFC CollisionOccupancy
		var colOccMD5 CollisionOccupancy
		resMFC := MFCHash(newWord)
		resMD5 := MD5Hash(word)

		isOkMFC := insert(newWord, resMFC%N, hTableMFC)
		if isOkMFC == 1 {
			collisionsMFC++
		} else {
			notEmptyMFC++
			occupancyMFC = notEmptyMFC / N
		}
		if count%1000 == 0 {
			colOccMFC = CollisionOccupancy{collisionsMFC, occupancyMFC}
			collOccMFCSlice = append(collOccMFCSlice, colOccMFC)
		}

		isOkMD5 := insert(word, resMD5%N, hTableMD5)
		if isOkMD5 == 1 {
			collisionsMD5++
		} else {
			notEmptyMD5++
			occupancyMD5 = notEmptyMD5 / N
		}
		if count%1000 == 0 {
			colOccMD5 = CollisionOccupancy{collisionsMD5, occupancyMD5}
			collOccMD5Slice = append(collOccMD5Slice, colOccMD5)
		}
		count++
	}

	X1 := "./points/collisionMFC.txt"
	Y1 := "./points/occupancyMFC.txt"

	X2 := "./points/collisionMD5.txt"
	Y2 := "./points/occupancyMD5.txt"

	fileX1, err := os.Create(X1)
	defer fileX1.Close()
	if err != nil {
		fmt.Println(err)
	}
	fileY1, err := os.Create(Y1)
	defer fileY1.Close()
	if err != nil {
		fmt.Println(err)
	}

	fileX2, err := os.Create(X2)
	defer fileX2.Close()
	if err != nil {
		fmt.Println(err)
	}
	fileY2, err := os.Create(Y2)
	defer fileY2.Close()
	if err != nil {
		fmt.Println(err)
	}

	for _, value := range collOccMFCSlice {
		collision := strconv.Itoa(value.Collision)
		occupancy := fmt.Sprintf("%f", value.Occupancy)
		fileX1.WriteString(collision + "\n")
		fileY1.WriteString(occupancy + "\n")
	}

	for _, value := range collOccMD5Slice {
		collision := strconv.Itoa(value.Collision)
		occupancy := fmt.Sprintf("%f", value.Occupancy)
		fileX2.WriteString(collision + "\n")
		fileY2.WriteString(occupancy + "\n")
	}
}
