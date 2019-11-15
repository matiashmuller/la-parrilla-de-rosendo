/*
 * Salvo raras excepciones, los nombres
 * de clase van en singular
 * o sea Comensal, no Comensales
 */
class Comensal {
	var property peso
	var property platosQueComio = []
	
	method comer(plato) { platosQueComio.add(plato) }
	method estaSatisfecho() {
		return self.pesoTotalPlatosIngeridos() >= peso * 0.01
	}
	
	method pesoTotalPlatosIngeridos() {
		return platosQueComio.sum({ plato => plato.peso() })
	}
	
	method leAgradaUnPlato(plato)
	
	// recibe una colección de platos, devuelve uno de esos platos
	method platoElegido(platosPosibles)
}

class Vegetariano inherits Comensal {
	override method leAgradaUnPlato(plato) {
		return plato.esAptoVegetariano() and plato.valoracion() >= 85
	}

	override method estaSatisfecho() {
		return super() 
		and 
		not platosQueComio.any({ plato => plato.esAbundante() })
		// lo que sigue está tan bien como el "not ... any"
//		platosQueComio.all({ plato => not plato.esAbundante() })				
	}

	override method platoElegido(platosPosibles) {
		return platosPosibles.find({ 
			plato => not plato.esAbundante()
		})
		// la idea es correcta pero Wollok no tiene
		// first con parámetro
//		return platosPosibles.first({ 
//			plato => not plato.esAbundante()
//		})
	}

	/*
	 * igual de bien que el anterior
	 */
	method platoElegido_variante(platosPosibles) {
		return platosPosibles.filter({ 
			plato => not plato.esAbundante()
		}).first()
		// la idea es correcta pero Wollok no tiene
		// first con parámetro
//		return platosPosibles.first({ 
//			plato => not plato.esAbundante()
//		})
	}
}


class HambrePopular inherits Comensal {
	override method leAgradaUnPlato(plato) {
		return plato.esAbundante()
	}

	override method platoElegido(platosPosibles) {
		return platosPosibles.max({ plato => plato.peso() })
	}
}


class PaladarFino inherits Comensal {
	override method leAgradaUnPlato(plato) {
		return plato.peso().between(150,300) and plato.valoracion() > 100
	}

	override method estaSatisfecho() {
		return super() 
		and
		platosQueComio.size().even()
		// even() es par, odd() es impar
		// platosQueComio.size() % 2 == 0 está igual de bien
		// OJO  platosQueComio.even() es incorrecto
	}

	override method platoElegido(platosPosibles) {
		if (platosQueComio.isEmpty()) {
			// nunca fue a la parrilla: agarro uno cualquiera
			return platosPosibles.anyOne()
		} else {
			const ultimo = platosQueComio.last()
			return platosPosibles.find({ plato =>
				plato.esAptoVegetariano() == ultimo.esAptoVegetariano()
			}) 
		}
	}
}










