object knightRider {
	method peso() { return 500 }
	method peligrosidad() { return 10 }
	method bultos() { return 1}
	method efectoDeAccidente() {}
}

object arenaAGranel {
	var peso = 0

	method peso() { return peso }
	method peligrosidad() { return 1 }
	method peso(_peso) { peso = _peso }
	method bultos() { return 1 }
	method efectoDeAccidente() { peso += 20 }
}

object bumblebee {
	var transformacion = auto
	
	method peligrosidad() { return transformacion.peligro()}
	method peso() { return 800 }
	method transformacion(_transformacion) { transformacion = _transformacion}
	method transformacion() { return transformacion }
	method bultos() { return 2 }
	method efectoDeAccidente() { transformacion = transformacion.cambiarEstado()}
}

object auto {
	method peligro() { return 15 }
	method cambiarEstado() {return robot}
}
object robot {
	method peligro() { return 30 }
	method cambiarEstado() { return auto }
}

object paqueteDeLadrillos {
	var cantidadLadrillos = 0

	method peligrosidad() { return 2}
	method peso() { return 2 * cantidadLadrillos}
	method cantidadLadrillos(_cantidadLadrillos) { cantidadLadrillos = _cantidadLadrillos}
	method cantidadLadrillos() { return cantidadLadrillos }
	method bultos() {
		return if (cantidadLadrillos <= 100) {
			1
		} else if (cantidadLadrillos.between(101, 300)) {
			2
		} else {
			3
		}
	}

	method efectoDeAccidente() {
		if (cantidadLadrillos < 12) {
			cantidadLadrillos = 0
		} else {
			cantidadLadrillos -= 12
		}
	}
}

object bateriaAntiaerea {
	var cargadaCon = misiles

	method peso() { return cargadaCon.peso()}
	method cargadaCon(_cargadaCon) { cargadaCon = _cargadaCon }
	method cargadaCon() { return cargadaCon }
	method peligrosidad() { return cargadaCon.peligro() }
	method bultos() { return cargadaCon.bultos() }
	method efectoDeAccidente(){ cargadaCon = otroObjeto }
}

object misiles {
	method peso() { return 300 }
	method peligro() { return 100 }
	method bultos() { return 2 }
}
object otroObjeto {
	method peso() { return 200 }
	method peligro() { return 0 }
	method bultos() { return 1 }
}

object residuosRadiactivos {
	var peso = 0

	method peso() { return peso }
	method peso(_peso) { peso = _peso }
	method peligrosidad() { return 200 }
	method bultos() { return 1 }
	method efectoDeAccidente() { peso += 15 }
}

object contenedorPortuario {
	const cosas = #{}

	method cosas() { return cosas }

	method peso() { return 100 + self.pesoDeCarga()}

	method pesoDeCarga() {
		return cosas.sum({objetoEnvuelto => objetoEnvuelto.peso()})
	}

	method peligrosidad() {
		return if (cosas.isEmpty()) {
			0
		} else {
			self.objetoConMayorPeligrosidad().peligrosidad()
		}
	}

	method objetoConMayorPeligrosidad() {
		return cosas.max({objetoEnvuelto => objetoEnvuelto.peligrosidad()})
	}

	method cargar(unaCosa) {
		cosas.add(unaCosa)
	}

	method descargar() {
		cosas.clean()
	}

	method bultos() {
		return self.cantidadDeBultosDeObjetos() + 1
	}

	method cantidadDeBultosDeObjetos() {
		return cosas.sum({cosa => cosa.bultos()})
	}

	method efectoDeAccidente() {
		cosas.forEach({cosa => cosa.efectoDeAccidente()})
	}
}

object embalajeDeSeguridad {
	var objetoEnvuelto = bumblebee

	method peso() {return objetoEnvuelto.peso()}
	method peligrosidad() { return objetoEnvuelto.peligrosidad() / 2}
	method objetoEnvuelto() { return objetoEnvuelto}
	method objetoEnvuelto(_objetoEnvuelto) { objetoEnvuelto = _objetoEnvuelto }
	method bultos() { return 2 }
	method efectoDeAccidente() {}
}
