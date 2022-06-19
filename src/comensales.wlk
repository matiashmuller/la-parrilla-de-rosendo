import platos.*

class Comensal {
	var peso
	const platosQueComio=[]
	
	method comer(plato) { platosQueComio.add(plato)}
	method leAgrada(plato)
	method leAgradanDe(platos) = platos.filter{p=>self.leAgrada(p)}
	method platoElegidoDe(platos) = self.leAgradanDe(platos)
	method estaSatisfecho() = self.pesoIngerido() >= peso*0.01 && self.condicionExtra()
	method pesoIngerido() = platosQueComio.sum{p=>p.peso()}
	method condicionExtra() = true
}

class Vegetariano inherits Comensal {
	override method leAgrada(plato) = plato.esAptoVegetariano() && plato.valoracion() >= 85
	override method condicionExtra() = platosQueComio.all{p=>!p.esAbundante()}
	override method platoElegidoDe(platos) = super(platos).findOrDefault({p=>!p.esAbundante()}, "Ninguno le gusta")
}

class HambrePopular inherits Comensal {
	override method leAgrada(plato) = plato.esAbundante()
	override method platoElegidoDe(platos) = super(platos).max{p=>p.peso()}
}

class PaladarFino inherits Comensal {
	override method leAgrada(plato) = plato.peso().between(150,300) && plato.valoracion() >100
	override method condicionExtra() = platosQueComio.size().even()
	override method platoElegidoDe(platos) = 
		if(platosQueComio.isEmpty()) platosQueComio.anyOne()
		else super(platos).find{ p=>p.sePareceA(platosQueComio.last()) }
}