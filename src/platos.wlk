class Plato {	
	// no va porque para algunas subclases 
	// es un cálculo
	// var property peso
	
	/*
	 * lo tengo que dejar abstracto
	 * para poder definir esAbundante()
	 */
	method peso()
	
	// es correcto que
	// esAptoVegetariano y valoracion
	// sean métodos abstractos, de hecho está muy bien.
	// Pero también pueden no serlo.
	
	/*
	 * Esto es lo único que se resuelve de 
	 * la misma forma para todos los platos
	 */
	method esAbundante() {
		return self.peso() > 250
	}
}


class Provoleta inherits Plato {
	/* poner var property es suficiente
	 * para hacer override del método abstracto
	 */
	 var property peso
	 
	 // esta forma también vale
//	 var peso
//	 override method peso() { return peso }

	var tieneEspecias
	var esCompleta
	
	method esAptoVegetariano() {
		return not esCompleta
	}	
	
	method valoracion() {
		if (self.esEspecial()) {
			return 120
		} else {
			return 85
		}
	}
	method esEspecial() {
		return (self.esAbundante() and tieneEspecias) or esCompleta 
	}
}


/*
 * es incorrecto que sea un object,
 * tengo que poder definir distintas hamburguesas
 * porque pueden tener distinto pan
 */
class HamburguesaDeCarne inherits Plato {
	const property peso = 250
	
	var property pan
	
	// esto también vale
//	override method peso() = 250

	method esAptoVegetariano() = false

	method valoracion() {
		return 60 + pan.valoracion()
	}
}

object panIndustrial {
	method valoracion() = 0
}

object panCasero {
	method valoracion() = 20
}

object panDeMasaMadre {
	method valoracion() = 45
}


class HamburguesaVegetariana inherits HamburguesaDeCarne {
	// la legumbre se representa como un String
	var property legumbre
	// OJO que el código de inicialización se evalúa
	// una sola vez, cuando se crea cada objeto.
	// si cambia la legumbre, cantidadDeLetras queda
	// refiriéndose a la legumbre "vieja" 
//	var cantidadDeLetras = legumbre.length() * 2
	
	override method esAptoVegetariano() = true
	override method valoracion() {
		return super() + 2 * legumbre.size()
		// puede ser size() o length(), los dos están igual de bien
	}
}

// así también estaría bien, pero tiene
// que estar el método nombre
// y en el método valoración en HamburguesaVegetariana 
// va legumbre.nombre().size() 
object lentejas {
	method nombre() = "lentejas"
}


class Parrillada inherits Plato {
	// implementarlo como una lista también es correcto
	var property cantidadDeCortes
	const property pesoPorCorte = 250
	
	method esAptoVegetariano() = false
	override method peso() { 
		return cantidadDeCortes * pesoPorCorte
	}

	method valoracion() {
		if (cantidadDeCortes >= 6) {
			return 140
		} else if (cantidadDeCortes.between(4,5)) {
			return 100
		} else {
			return 70
		}
	}
}








