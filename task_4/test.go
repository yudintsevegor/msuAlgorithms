package main

import (
	"fmt"
	"reflect"
)


func main(){
	x := []int{0, 1, 2}
	z := []int{0, 1, 2}
	y := []int{1, 0, 2}
	/*mapka := map[[]int]string{
		{1, 0, 2}: "",
		{1, 1, 1}: "",
	}

	_, ok := mapka[x]
	fmt.Println(ok)
	*/

	fmt.Println(reflect.DeepEqual(x, z))
	fmt.Println(reflect.DeepEqual(y, z))
}
