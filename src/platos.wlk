class Plato {
	var property peso = 250 // Preguntar como hicieron el peso, var o metodo?
	
	method esAptoVegetariano() = false
	method valoracion()
	method esAbundante() = self.peso()> 250
	method sePareceA(plato) = plato.esAptoVegetariano() == self.esAptoVegetariano()
}

class Provoleta inherits Plato {
	var tieneEspecias
	const esCompleta
	
	override method esAptoVegetariano() = !esCompleta
	override method valoracion() = if(self.esEspecial()) 120 else 85
	method esEspecial() = self.esAbundante() && tieneEspecias || esCompleta
}

class HamburCarne inherits Plato {
	var pan
	
	method configurarPan(unPan) { pan = unPan }
	override method valoracion() =  60 + pan.valoracion()
}

// Preguntar como hicieron esto del pan
class PanIndustrial {
	method valoracion() = 0
}

class PanCasero  {
	method valoracion() = 20
}

class PanMasaMadre {
	method valoracion() = 45
}

class HamburVeg inherits HamburCarne {
	var legumbre
	
	override method esAptoVegetariano() = true
	override method valoracion() = super() + 2*legumbre.size()
}

class Parrillada inherits Plato{
	var cantCortesCarne
	
	override method peso() = 250*cantCortesCarne
	override method valoracion() =
		if (cantCortesCarne < 4) 70
		else if (cantCortesCarne < 6) 100
		else 140
}