package utils

import (
	"fmt"
)

// fmt.print() a message when a connection is started
func PrintConnectionStart() {
	fmt.Println("\n--- New conn Started ---------------------")
}

// fmt.print() a message when a connection is started
func PrintConnectionResult(success bool) {
	if success {
		fmt.Print("--- conn stablished ----------------------\n\n")
		} else {
		fmt.Print("--- conn refused -------------------------\n\n")
	}
}

