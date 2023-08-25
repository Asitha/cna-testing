package main

import (
	"fmt"
	"log"
	"net/http"
)

func main() {
	serverMux8080 := http.NewServeMux()
	serverMux6657 := http.NewServeMux()
	serverMux9876 := http.NewServeMux()
	serverMux9090 := http.NewServeMux()

	serverMux8080.HandleFunc("/greeting8080/hello", hello8080)
	serverMux6657.HandleFunc("/greeting6657/hello", hello6657)
	serverMux9876.HandleFunc("/greeting9876/hello", hello9876)
	serverMux9090.HandleFunc("/greeting9090/hello", hello9090)

	log.Println("Starting server...")

	go func() {
		check(http.ListenAndServe(":6657", serverMux6657))
	}()

	go func() {
		check(http.ListenAndServe(":8080", serverMux8080))
	}()

	go func() {
		check(http.ListenAndServe(":9876", serverMux9876))
	}()

	check(http.ListenAndServe(":9090", serverMux9090))
}

func check(err error) {
	if err != nil {
		log.Fatal(err)
	}
}

func hello8080(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hello from port 8080, %s", r.URL.Query().Get("name"))
}

func hello6657(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hello from port 6657, %s", r.URL.Query().Get("name"))
}

func hello9876(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hello from port 9876, %s", r.URL.Query().Get("name"))
}

func hello9090(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hello from port 9090, %s", r.URL.Query().Get("name"))
}
