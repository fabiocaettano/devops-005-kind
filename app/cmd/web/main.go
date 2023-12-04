package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
)

func main() {
	http.HandleFunc("/configmap", ConfigMap)
	http.ListenAndServe(":8080", nil)
}

func ConfigMap(w http.ResponseWriter, r *http.Request) {
	data, err := os.ReadFile("/app/myfamily/family.txt")
	if err != nil {
		log.Fatalf("Error reading file : %s", err)
	}
	w.Write([]byte("<h1>Config Map</h1>"))
	fmt.Fprintf(w, "My Family: %s", string(data))

}
