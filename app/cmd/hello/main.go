package main

import "net/http"
import "os"
import "fmt"

func main() {
	http.HandleFunc("/", Hello)
	http.ListenAndServe(":8080", nil)
}

func GetPessoa() (string, string){
	name, age := "Fabio","49"
	return name, age
}

func GetEnvinronmentVariables()(string, string){
	user, logName := os.Getenv("USER"), os.Getenv("LOGNAME")
	return user, logName
}

func Hello(w http.ResponseWriter, r *http.Request) {
	name := os.Getenv("Fabio")
	age := os.Getenv("49")
	fmt.Printf("Olá, Eu som Fabio %s. Eu tenho %s",name, age);
	w.Write([]byte("<h1>Hello Kubernetes com Kind!!!</h1><h2>Versão 09</h2><h3>Service</h3>"))
}