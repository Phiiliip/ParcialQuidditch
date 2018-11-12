object saetaDeFuego {
	
	method velocidad(){
		return 100
	}
	
	//------------------------------
	
	// Punto 4:C
	
	method recibirGolpe(){
		
	}
	
}

class Nimbus {
	
	var property salud
	var property anioFabricacion
	
	constructor(health,year){
		salud = health
		anioFabricacion = year
	}
	
	method velocidad(){
		return (80 - self.aniosDeAntiguedad()) * (salud/100)
	}
	
	method aniosDeAntiguedad(){
		return (new Date()).year() - anioFabricacion
	}
	
	//------------------------------
	
	//Punto 4:c
	
	method recibirGolpe(){
		salud -= (salud/10)
	}
}


object mercadoDeEscobas{
	var property velocidadEstandar
	
	method actualizarValor(cant){
		velocidadEstandar = cant
	}
}
