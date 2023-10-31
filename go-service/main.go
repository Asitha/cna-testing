package main

import (
	"fmt"
	"net/http"
	"os"
)

func main() {
	serverMux := http.NewServeMux()
	serverMux.HandleFunc("/greeter/greet", greet)
	err := http.ListenAndServe(":9090", serverMux)
	if err != nil {
		panic(err)
	}
}

func greet(w http.ResponseWriter, r *http.Request) {
	// read from a file a line
	greeterText := os.Getenv("GREETING_TEXT")
	name, err := os.ReadFile("name.txt")
	if err != nil {
		fmt.Printf("Error reading file: %s", err)
		w.WriteHeader(http.StatusInternalServerError)
		fmt.Fprint(w, "Error reading file")
		return
	}

	fmt.Fprintf(w, "%s, %s!\n", greeterText, string(name))
}
