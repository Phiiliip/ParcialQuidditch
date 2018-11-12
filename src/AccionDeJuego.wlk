class BuscandoLaSnitch {
	
	var property turnosBuscando = 0
	
	constructor(){
		
	}
	
	method turno(jugador){
		if(self.encontroLaSnitch(jugador)){
			jugador.encontroLaSnitch()
		}
		
		turnosBuscando++
	}
	
	method encontroLaSnitch(jugador){
		return (new Range(1,1000)) < jugador.habilidad() + turnosBuscando
	}
	
}

class PersiguiendoLaSnitch{
	var property kmsRecorridos = 0
	
	constructor(){}
	
	method turno(jugador){
		if(self.puedeAtraparla()){
			jugador.snitchAtrapada()
		}
		self.recorrerKms(jugador)
	}
	
	method puedeAtraparla(){
		return kmsRecorridos > 5000
	}
	
	method recorrerKms(jugador){
		kmsRecorridos += jugador.velocidad() / 1.6
	}
}
