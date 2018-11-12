import Escobas.*
import AccionDeJuego.*

class Jugador {
	
	var property skill
	var property peso
	var property escoba
	var property equipo
	var property reflejos
	var property tieneLaQuaffle = false
	
	constructor(sk,pe,es,eq,re){
		self.skill(sk)
		self.peso(pe)
		self.escoba(es)
		self.equipo(eq)
		self.reflejos(re)
	}
	
	// PUnto 1 : A
	
	method nivelManejoEscoba(){
		return skill / peso
	}
	
	// Punto 1 : B
	
	method velocidad(){
		return self.nivelManejoEscoba() * escoba.velocidad()
	}
	
	// Punto 1 : C
	
	method habilidad(){
		return self.velocidad() + skill 
	}
	
	//-----------------------------------------------------
	
	// Punto 2:A
	method lePasaElTrapo(otroJugador){
		return self.habilidad() > 2*otroJugador.habilidad()
	}
	
	
	//Punto 2 : B
	method esGroso(){
		return self.tieneBuenPromedio() && self.porEncimaDeLaMedia()
	}
	
	method tieneBuenPromedio(){
		return self.habilidad() > equipo.promedioHabilidad()
	}
	
	method porEncimaDeLaMedia(){
		return self.velocidad() > mercadoDeEscobas.velocidadEstandar()
	}
	
	// Punto 2 : C
	
	method esEstrella(otroTeam){
		return otroTeam.jugadores().all({player => self.lePasaElTrapo(player)})
	}	
	
	//-----------------------------------------------------
	
	// Punto 3 : Metodo abstracto
	
	method turno(otroTeam)
	method blancoUtil()
	
	method tieneLaQuaffle(){
		return tieneLaQuaffle
	}
	
	method ganarLaQuaffle(){
		tieneLaQuaffle = true
	}
	
	method perderLaQuaffle(otroTeam){
		otroTeam.ganarQuaffle()
		tieneLaQuaffle = false
	}
	
	method modificarPuntosYSkills(points,ski){
		equipo.ganarPuntos(points)
		self.modificarSkill(ski)
	}
	
	method modificarSkill(cantidad){
		skill += cantidad
	}
	
	//-----------------------------------------------------
	
	// Punto 3,5:
	
	method tenerSuerte(inferior,superior,num){
		return (new Range(inferior,superior)) <= num
	}
	
	//-----------------------------------------------------
	
	// Punto 4:
	
	method puedeBloquear(unJugador)
	
	//------------------------------
	
	// Punto 4 C :
	
	method golpeadoPorBludger(otroTeam){
		self.modificarSkill(-2)
		escoba.recibirGolpe()
	}
	
}

class Cazador inherits Jugador{
	
	var property punteria
	var property fuerza
	
	constructor(sk,pe,es,eq,re,pun,fue) = super(sk,pe,es,eq,re){
		self.punteria(pun)
		self.fuerza(fue)
	}
	
	// Punto 1 : c
	override
	method habilidad(){
		return super() + punteria * fuerza
	}
	
	//-----------------------------------------------------
	
	//Punto 3 : 
	override
	method turno(otroTeam){
		if(self.tieneLaQuaffle()){
			self.intentarMeterGol(otroTeam)
		}
	}
	
	method intentarMeterGol(otroTeam){
		if(!otroTeam.loBloquea(self)){
			self.modificarPuntosYSkills(10,5)
		}else{
			self.modificarSkill(-2)
			otroTeam.beneficiarBloqueador(self,10)
		}
		self.perderLaQuaffle(otroTeam)
	}
	
	//-----------------------------------------------------
	
	//Punto 4:
	
	override
	method puedeBloquear(unJugador){
		return self.lePasaElTrapo(unJugador)
	}
	
	override
	method blancoUtil(){
		return self.tieneLaQuaffle()
	}
	
	//Punto 4:c:
	
	override
	method golpeadoPorBludger(otroTeam){
		super(otroTeam)
		self.perderLaQuaffle(otroTeam)
	}
}

class Guardian inherits Jugador{
	
	var property fuerza
	
	constructor(sk,pe,es,eq,re,fue) = super(sk,pe,es,eq,re){
		self.fuerza(fue)
	}
	
	// Punto 1: c
	override
	method habilidad(){
		return super() + reflejos + fuerza
	}
	
	//-----------------------------------------------------
	
	//Punto 3:
	override
	method turno(otroTeam){
		
	}
	
	//-----------------------------------------------------
	
	//Punto 4:
	
	override
	method puedeBloquear(unJugador){
		return self.tenerSuerte(1,3,3)
	}
	
	override
	method blancoUtil(){
		return !equipo.tieneLaQuaffle()
	}

}

class Golpeador inherits Jugador{
	
	var property punteria
	var property fuerza
	
	constructor(sk,pe,es,eq,re,pun,fue) = super(sk,pe,es,eq,re){
		self.punteria(pun)
		self.fuerza(fue)
	}
	
	//Punto 1: c
	override
	method habilidad(){
		return super() + punteria + fuerza
	}
	
	//-----------------------------------------------------
	
	// Punto 3:
	
	override
	method turno(otroTeam){
		var blancoUtil = otroTeam.unBlancoUtil()
		if(self.puedeGolpear(blancoUtil)){
			blancoUtil.golpeadoPorBludger(otroTeam)
			self.modificarSkill(1)
		}	
	}
	
	method puedeGolpear(otroJugador){
		return self.masPunteriaQueReflejos(otroJugador) || self.tenerSuerte(1,10,8)
	}
	
	method masPunteriaQueReflejos(otroJugador){
		return punteria > otroJugador.reflejos()
	}
	
	//-----------------------------------------------------
	
	// Punto 4:
	
	override
	method puedeBloquear(unJugador){
		return self.esGroso()
	}
	
	override
	method blancoUtil(){
		return false
	}

}

class Buscador inherits Jugador{
	
	var property estadoDeBusqueda = new BuscandoLaSnitch()
	var property vision
	
	constructor(sk,pe,es,eq,re,vis) = super(sk,pe,es,eq,re){
		self.vision(vis)
	}
	
	//punto 1 : C
	override
	method habilidad(){
		return super() + reflejos + vision
	}
	
	//-----------------------------------------------------
	
	//Punto 3
	override
	method turno(otroTeam){
		estadoDeBusqueda.turno(self)
	}
	
	method encontroLaSnitch(){
		estadoDeBusqueda = new PersiguiendoLaSnitch()
	}
	
	method snitchAtrapada(){
		self.modificarPuntosYSkills(150,10)
		estadoDeBusqueda = new BuscandoLaSnitch()
	}
	
	//-----------------------------------------------------
	
	//Punto 4:
	
	override
	method puedeBloquear(unJugador){
		return false
	}
	
	override
	method blancoUtil(){
		return estadoDeBusqueda.blancoUtil()
	}
	
	//------------------------------
	
	//Punto 4:C:
	
	override
	method golpeadoPorBludger(otroTeam){
		super(otroTeam)
		self.reiniciarBusqueda()
	}
	
	method reiniciarBusqueda(){
		estadoDeBusqueda = new BuscandoLaSnitch()
	}
	
}
