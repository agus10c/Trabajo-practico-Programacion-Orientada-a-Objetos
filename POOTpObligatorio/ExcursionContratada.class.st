"
Clase  TuplaFechaSalCupo de trabajo practico obligatorio que corresponde a una tupla de una excrusion opcional seleccionada con su respectiva cantidad de personas.

Contrato -----(1...*)-> TuplaExcSelCantPers

    Instance Variables
	cantidadPersonas:		<Object>
	unaExcursion:		<Object>

"
Class {
	#name : #ExcursionContratada,
	#superclass : #Object,
	#instVars : [
		'excursionOpcional',
		'cantidadPersonas'
	],
	#category : #POOTpObligatorio
}

{ #category : #constructor }
ExcursionContratada class >> crearConExcursionOpcional: unaExc yCantidadPersonas: unaCant [

	| unaTupla |
	unaTupla := self new.
	unaTupla
		inicializarConExcrusionOpcional: unaExc
		yCantidadPersonas: unaCant.
	^ unaTupla
]

{ #category : #observadores }
ExcursionContratada >> getCantidadPersonas [
^cantidadPersonas 

]

{ #category : #observadores }
ExcursionContratada >> getExcursionOpcional [ 
^excursionOpcional 

]

{ #category : #inicializadores }
ExcursionContratada >> inicializarConExcrusionOpcional: unaExc yCantidadPersonas:unaCant [
	excursionOpcional :=unaExc.
	cantidadPersonas :=unaCant 
]

{ #category : #aplicacion }
ExcursionContratada >> obtenerCostoDeExcursionContratada [
	 ^(excursionOpcional getValor)*cantidadPersonas  
]
