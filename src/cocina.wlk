/*
 * esta puede ser object o class,
 * cualquiera de las dos está OK
 */
object cocina {
	var platosPreparados = []
	
	method tieneBuenaOfertaVegetariana() {
		return 
			(self.platosNoVegetarianos().size() -
			 self.platosVegetarianos().size()).abs() <= 2 
	}

	/*
	 * está igual de bien que la anterior
	 */
	method tieneBuenaOfertaVegetariana_variante() {
		return
			self.platosVegetarianos().size() + 2 >= 
			self.platosNoVegetarianos().size()
	}
	
	method platosVegetarianos() {
		return platosPreparados.filter({ 
			plato => plato.esAptoVegetariano()
		})
	}

	method platosNoVegetarianos() {
		return platosPreparados.filter({ 
			plato => not plato.esAptoVegetariano()
		})
	}
	
	method platoFuerteCarnivoro() {
		return self.platosNoVegetarianos().max({ plato => plato.valoracion() })
	}
	
	method platosQueLeGustan(persona) {
		return platosPreparados.filter({ 
			plato => persona.leAgradaUnPlato(plato)
		})
	}
	
	
	// atenti: las tres formas están igual de bien
	
	/*
	 * no hay ningún plato que les guste a los dos
	 */
	method sonDePolosOpuestos(pers1, pers2) {
		return not platosPreparados.any({ plato =>
			pers1.leAgradaUnPlato(plato) 
			and 
			pers2.leAgradaUnPlato(plato)
		})
	}

	/*
	 * tomando solamente los que le gustan al primero,
	 * ninguno le gusta al segundo
	 */
	method sonDePolosOpuestos_variante(pers1, pers2) {
		const leGustanAl1 = platosPreparados.filter({ 
			plato =>
			pers1.leAgradaUnPlato(plato) 
		})
		return not leGustanAl1.any({ plato =>
			pers2.leAgradaUnPlato(plato)
		})
	}

	/*
	 * tomando los conjuntos de platos que le gustan
	 * a cada uno, la intersección debe ser vacía
	 */
	method sonDePolosOpuestos_variante2(pers1, pers2) {
		const leGustanAl1 = platosPreparados.filter({ 
			plato =>
			pers1.leAgradaUnPlato(plato) 
		}).asSet()
		const leGustanAl2 = platosPreparados.filter({ 
			plato =>
			pers2.leAgradaUnPlato(plato) 
		}).asSet()
		return leGustanAl1.intersection(leGustanAl2).isEmpty()
	}
	
	method servirUnPlato(pers) {
		if (self.platosQueLeGustan(pers).isEmpty()) {
			self.error("No se le puede servir nada")
			// esto está mal, si se pide lanzar un error
			// es incorrecto retornar un valor
//			return "error"
		}
		// como el error corta ejecución, no hace
		// falta poner else
		
		// si sé que es una lista, en lugar de anyOne() puede ser first()
		// esta línea es la **única** que cambia
		// para la parte 4
//		const platoAServir = self.platosQueLeGustan(pers).anyOne()
		const platoAServir = pers.platoElegido(self.platosQueLeGustan(pers))
		
		platosPreparados.remove(platoAServir)
		pers.comer(platoAServir)
	}
}








