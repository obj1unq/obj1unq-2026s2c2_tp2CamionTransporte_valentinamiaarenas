import cosas.*
import almacen-y-rutas.*

object camion {
	const property cosas = #{}
	const tara = 1000
	const pesoMaximoAceptable = 2500
		
	method cosas() { return cosas }

	method cargar(unaCosa) {
		self.validarCarga(unaCosa)
		cosas.add(unaCosa)
	}

	method validarCarga(unaCosa) {
		if (cosas.contains(unaCosa)) {
			self.error("Este objeto ya se encuentra cargado en el camion")
		}
	}

	method descargar (unaCosa) {
		self.validarDescarga(unaCosa)
		cosas.remove(unaCosa)
	}

	method validarDescarga(unaCosa) {
		if (not cosas.contains(unaCosa)) {
			self.error("Este objeto no se encuentra en el camion")
		}
	}

	method todoTienePesoPar() {
		return cosas.all({cosa => self.esPesoPar(cosa.peso())})
	}

	method esPesoPar(peso) { return peso % 2 == 0 }

	method tieneObjetoConPeso(kilogramos) {
		return cosas.any({cosa => cosa.peso() == kilogramos})
	}

	method pesoTotal() { return tara + self.pesoDeCarga() }

	method pesoDeCarga() {
		return cosas.sum({cosa => cosa.peso()})
	}

	method estaExcedidoDePeso() { return self.pesoTotal() > pesoMaximoAceptable }

	method objetoConPeligrosidadDe(nivel) {
		return cosas.find({cosa => cosa.peligrosidad() == nivel})
	}

	method objetosQueSuperanNivelPeligrosidad(nivel) {
		return cosas.filter({cosa => cosa.peligrosidad() > nivel})
	}

	method objetosConMasPeligrososQue(unObjeto) {
		return self.objetosQueSuperanNivelPeligrosidad(unObjeto.peligrosidad())
	}

	method puedeCircularEnRuta(nivelPeligrosidad) {
		return not self.estaExcedidoDePeso() and (self.nivelDePeligrosidadCargado() <= nivelPeligrosidad)
	}

	method nivelDePeligrosidadCargado() {
		return cosas.sum({cosa => cosa.peligrosidad()})
	}

	method tieneObjetoDePesoEntre(pesoMinimo, pesoMaximo) {
		return cosas.any({cosa => cosa.peso().between(pesoMinimo, pesoMaximo)})
	}

	method objetoConMayorPeso() {
		return cosas.max({cosa => cosa.peso()})
	}

	method pesoDeLosObjetos() {
		return cosas.map({cosa => cosa.peso()})
	}

	method cantidadDeBultosDeObjetos() {
		return cosas.sum({cosa => cosa.bultos()})
	}

	method sufrirAccidente() {
		cosas.forEach({cosa => cosa.efectoDeAccidente()})
	}

	method llegarADestino(destino) {
		destino.almacenarCarga(self.cosas())
		cosas.clear()
	}

	method transportar(destino, camino) {
		self.validarTransportar(camino)
		self.llegarADestino(destino)
	}
	
	method validarTransportar(camino) {
		if(not camino.puedeCircular(self)) {
			self.error("No puede circular por el camino")
		}
	}
}
