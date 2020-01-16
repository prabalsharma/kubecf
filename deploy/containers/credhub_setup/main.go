package main

import (
	"fmt"
	"time"
)

func main() {
	fmt.Println("Testing stuff")
	for {
		time.Sleep(24 * time.Hour)
	}
}
