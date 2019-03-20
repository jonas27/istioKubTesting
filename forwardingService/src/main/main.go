package main

import (
	"io/ioutil"
	"log"
	"net/http"
)

func main() {
	http.HandleFunc("/forward", forward)
	http.HandleFunc("/info", info)
	http.ListenAndServe(":3001", nil)
}

func forward(w http.ResponseWriter, r *http.Request) {
	resp, err := http.Get("http://hello:3000")
	//resp, err := http.Get("http://google.de")
	if err != nil {
		log.Println(err)
	}
	defer resp.Body.Close()
	body, _ := ioutil.ReadAll(resp.Body)
	w.Write([]byte(string(body) + " | foward version1"))
}
func info(w http.ResponseWriter, r *http.Request) {
	w.Write([]byte("This is version1. It is calling url: hello:3000"))
}
