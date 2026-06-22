"
Clase ViajeEspecial. Subclase de Viaje.
        			   Viaje 
         			      ^
		    ViajeEspecial
 Instance Variables
	ciudad:		<Object>
	disponibilidad:		<Object>
	fechaRegreso:		<Object>
	fechaSalida:		<Object>


"
Class {
	#name : #ViajeEspecial,
	#superclass : #Viaje,
	#instVars : [
		'ciudad',
		'fechaSalida',
		'fechaRegreso',
		'disponibilidad'
	],
	#category : #POOTpObligatorio
}

{ #category : #constructor }
ViajeEspecial class >> crearConNombre: unNombre yCostoPorPersona: unCosto yImpuesto: unImpuesto yValorPlus: unValor yCiudad: unaCiudad yFechaSalida: unaFecha yFechaRegreso: otraFecha yDisponibilidad: unCupo [
  |unViajeEspecial|
  unViajeEspecial  := self new.
  unViajeEspecial iniConNombre: unNombre yCostoPorPersona: unCosto yImpuesto: unImpuesto yValorPlus: unValor yCiudad: unaCiudad yFechaSalida: unaFecha yFechaRegreso: otraFecha yDisponibilidad: unCupo.
  ^unViajeEspecial 


]

{ #category : #aplicacion }
ViajeEspecial >> cambiarFechaConFechaACambiar: feCambio fechaNueva: unaFecha [

	| diasDeViaje |
	diasDeViaje := (fechaRegreso - fechaSalida) abs.
	fechaSalida := unaFecha.
	fechaRegreso := (unaFecha + diasDeViaje) asDate.
	^ true
]

{ #category : #aplicacion }
ViajeEspecial >> desocuparCuposConCantidad: cantP yFecha: unaFecha [
  disponibilidad := disponibilidad + cantP.


]

{ #category : #propios }
ViajeEspecial >> esViajeOrganizado [
^ false.
]

{ #category : #visualizadores }
ViajeEspecial >> getCiudad [
^ciudad 
]

{ #category : #visualizadores }
ViajeEspecial >> getDisponibilidad [
	^disponibilidad 
]

{ #category : #visualizadores }
ViajeEspecial >> getFechaRegreso [
	^fechaRegreso 
]

{ #category : #visualizadores }
ViajeEspecial >> getFechaSalida [ 
^fechaSalida. 
]

{ #category : #inicializadores }
ViajeEspecial >> iniConNombre: unNombre yCostoPorPersona: unCosto yImpuesto: unImpuesto yValorPlus: unValor yCiudad: unaCiudad yFechaSalida: unaFecha yFechaRegreso: otraFecha yDisponibilidad: unCupo [
	self inicializarConNombre: unNombre yCostoPorPersona: unCosto yImpuesto: unImpuesto yValorPlus: unValor.
	ciudad := unaCiudad.
	fechaSalida := unaFecha.
	fechaRegreso := otraFecha.
	disponibilidad  := unCupo.
]

{ #category : #inicializadores }
ViajeEspecial >> iniciarCiudad: unaCiudad  yFechaRegreso: unaFechaR [
"ciudad fechaRegreso colSalida"
ciudad:= unaCiudad.
fechaRegreso :=unaFechaR.


]

{ #category : #aplicacion }
ViajeEspecial >> ocuparCuposConCantidad:unaCantPers yFecha: unaFecha [
  disponibilidad := disponibilidad - unaCantPers.

]

{ #category : #Modificadores }
ViajeEspecial >> setDisponivilidad: nuevaDisponivilidad [
 disponibilidad := nuevaDisponivilidad. 
]

{ #category : #aplicacion }
ViajeEspecial >> verificarCupoConCantidadPersonas: cantP yFecha: unaFecha [

	^ disponibilidad >= cantP and: [ fechaSalida = unaFecha ]
]

{ #category : #aplicacion }
ViajeEspecial >> verificarEntreFechasConFecha1: unaFecha yFecha2: otraFecha [
	^ fechaSalida between: unaFecha and:otraFecha 
]

{ #category : #aplicacion }
ViajeEspecial >> verificarExistenciaConNombre: unNombre [

]

{ #category : #aplicacion }
ViajeEspecial >> verificarViajeRealizado [

	^ fechaSalida < Date today
]
