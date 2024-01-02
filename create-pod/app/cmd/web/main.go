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
	data, err := os.ReadFile("/app/external/files/family.txt")
	if err != nil {
		log.Fatalf("Error reading file : %s", err)
	}
	fmt.Fprintln(w, "Versão 01 | POD")
	fmt.Fprintln(w, "My Family:")
	fmt.Fprintf(w, "%s", string(data))
}
