package main

import (
	"fmt"
	"net/http"
)

func main() {
	http.HandleFunc("/", homeHandler)
	http.HandleFunc("/hello", helloHandler)
	http.ListenAndServe(":3000", nil)
}

func homeHandler(w http.ResponseWriter, r *http.Request) {
	if r.URL.Path != "/" {
		fmt.Fprint(w, "This is your path\n")
		fmt.Fprintln(w, r.URL.Path)
		return
	}
	fmt.Fprint(w, "welcome home\n")
}
func helloHandler(w http.ResponseWriter, r *http.Request) {
	if r.URL.Path != "/hello" {
		fmt.Fprint(w, "This is your path\n")
		fmt.Fprintln(w, r.URL.Path)
		return
	}
	//fmt.Fprint(w, "V1: welcome to hello\n")
	http.Get("http://productpage")
}
