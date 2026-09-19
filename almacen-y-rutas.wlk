import cosas.*
import camion.*

object almacen {
    const property cosas = []

    method almacenarCarga(objetos) {
        cosas.addAll(objetos)
    }
}

object ruta9 {

    method puedeCircular(unCamion) {
        return unCamion.puedeCircularEnRuta(20)
    }
}

object caminosVecinales {
    var pesoMaximoPermitido = 0
    
    method puedeCircular(unCamion) {
        return unCamion.pesoTotal() <= pesoMaximoPermitido
    }

    method pesoMaximoPermitido(_pesoMaximoPermitido) {
        pesoMaximoPermitido = _pesoMaximoPermitido
    }
}