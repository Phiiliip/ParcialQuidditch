class Equipo {
	
	var property jugadores = #{}
	var property puntaje = 0
	
	// Punto 2 : C:
	method tieneUnaEstrella(otroTeam){
		return jugadores.any({player => player.esEstrella(otroTeam)})
	}
	
	//-----------------------------------------------------
	
	// Punto 3
	
	method jugarContra(otroTeam){
		jugadores.forEach({jugador => jugador.turno(otroTeam)})
	}
	
	method ganarPuntos(cantidad){
		puntaje += cantidad
	}
	
	//-----------------------------------------------------
	
	// Punto 3 : Cazador:
	
	method loBloquea(jugador){
		return jugadores.any({player => player.puedeBloquear(jugador)})
	}
	
	method elBloqueador(jugador){
		return jugadores.find({player => player.puedeBloquear(jugador)})
	}
	
	method beneficiarBloqueador(jugador,skill){
		var bloqueador = self.elBloqueador(jugador)
		bloqueador.aumentarSkill(skill)
	}
	
	method ganarQuaffle(){
		var elMasRapido = jugadores.max({player => player.velocidad()})
		elMasRapido.ganarLaQuaffle()
	}
	
	//-----------------------------------------------------
	
	// Punto 4:
	
	method tieneLaQuaffle(){
		return jugadores.any({player => player.tieneLaQuaffle()})
	}
	
}
