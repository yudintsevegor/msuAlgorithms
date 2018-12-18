package main


import (
	"strings"
)

var punctuationMark = map[string]string{
			".": "",
			",": "",
			":": "",
			";": "",
			"-": "",
			"\"": "",
			"*": "",
			")": "",
			"(": "",
			"”": "",
			"“": "",
			"...": "",
			"....": "",
			"!": "",
			"?": "",
			"’s": "",
			"n’t": "",
			"’re": "",
}
var punctuation = ". & , & : & ; & - & \" & * & ) & ( & “ & ” & ... & ? & !"

func TextParsing(symbol string) (string, bool){
	if !strings.ContainsAny(symbol, punctuation){
		return symbol, true
	}
	if _, ok := punctuationMark[symbol]; ok{
		return symbol, false
	}
	newWord := symbol

	for char, _ := range punctuationMark{
		tmp := strings.Split(newWord, "")
		if strings.HasPrefix(newWord, char){
			newWord = strings.Join(tmp[1:len(tmp)], "")
			newWord, _ = TextParsing(newWord)
			continue
		}
		if strings.HasSuffix(newWord, char){
			switch char{
			case "....":
				newWord = strings.Join(tmp[:len(tmp) - 4], "")
				newWord, _ = TextParsing(newWord)
				return newWord, true
				continue
			case "...", "’re", "n’t":
				newWord = strings.Join(tmp[:len(tmp) - 3], "")
				newWord, _ = TextParsing(newWord)
				return newWord, true
				continue
			case "’s":
				newWord = strings.Join(tmp[:len(tmp) - 2], "")
				newWord, _ = TextParsing(newWord)
				return newWord, true
				continue
			default:
				newWord = strings.Join(tmp[:len(tmp) - 1], "")
				newWord, _ = TextParsing(newWord)
				return newWord, true
				continue
			}
		}
	}
	return newWord, true
}

