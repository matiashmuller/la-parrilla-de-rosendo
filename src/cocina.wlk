import platos.*
import comensales.*

object cocina {
	const platos=[]
	
	method buenaOfVege() =  self.cantNoVege() - self.cantVege() <=2
	method cantNoVege() = platos.size() - self.cantVege()
	method cantVege() = platos.count{p=>p.esAptoVegetariano()}
	method fuerteCarnivoro() = self.noVeges().max{p=>p.valoracion()}
	method noVeges() = platos.filter{p=>!p.esAptoVegetariano()}
	method platosGustanA(comensal) = platos.filter{p=>comensal.leAgrada(p)}
	method sonOpuestos(com1,com2) = platos.all{ p=>! (com1.leAgrada(p) && com2.leAgrada(p)) }
	method servir(comensal) {
		if (comensal.platoElegidoDe(platos) == "Ninguno le gusta") self.error("No le gusta la oferta")
		platos.remove(comensal.platoElegidoDe(platos))
		comensal.comer(comensal.platoElegidoDe(platos))
	}
	
}