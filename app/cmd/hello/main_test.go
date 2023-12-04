package main

import "testing"

func TestHello(t *testing.T){
	pessoa, _ := GetPessoa()
	esperado := "Fabio"
	if pessoa != esperado {
		t.Errorf("Esperado %s, Resultado %s",esperado, pessoa)
	}
}

func TestEnvinronmentVariable(t * testing.T){
	user, logName  := GetEnvinronmentVariables()
	userEsperado := "fabio"
	logNameEsperado := "fabio"

	if user != userEsperado{
		t.Errorf("User Esperado %s, Resultado %s",userEsperado, user)
	}

	if logName != logNameEsperado{	
		t.Errorf("LogName Esperado %s, Resultado %s", logNameEsperado, logName)
	}
}