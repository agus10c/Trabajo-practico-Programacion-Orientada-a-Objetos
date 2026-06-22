"
Clase Viaje de trabajo practico obligatorio.
EmpresaTurismo -----(1...*)---> Viaje

    Instance Variables
	costoPorPersona:		<Object>
	impuesto:		<Object>
	nombre:		<Object>
	valorPlus:		<Object>


"
Class {
	#name : #Viaje,
	#superclass : #Object,
	#instVars : [
		'nombre',
		'costoPorPersona',
		'impuesto',
		'valorPlus',
		'activo'
	],
	#category : #POOTpObligatorio
}

{ #category : #constructor }
Viaje class >> crearConNombre: unNombre yCostoPorPersona: unCosto yImpuesto: unImpuesto yValorPlus: unValorPlus [
	|unViaje|
	unViaje := self new.
	unViaje inicializarConNombre: unNombre yCostoPorPersona: unCosto yImpuesto: unImpuesto yValorPlus: 		unValorPlus.
	^unViaje 

]

{ #category : #aplicacion }
Viaje >> agregarExcurcionOpcionalConNombre: nomExcursion yCosto: unCosto [
	^false
]

{ #category : #aplicacion }
Viaje >> agregarFechaSalida: unaFecha yCupo: unCupo [ 
	^false
]

{ #category : #aplicacion }
Viaje >> buscarExcursionConNombre: nomExcursion [
	^nil
]

{ #category : #aplicacion }
Viaje >> calcularCosto: cantPersonas [
  ^(cantPersonas * costoPorPersona) + impuesto.  
]

{ #category : #aplicacion }
Viaje >> calcularCostoConCantPersonas: cantPersonas [
  ^(cantPersonas * costoPorPersona) + impuesto.


]

{ #category : #aplicacion }
Viaje >> darDeBaja [
  activo := false.
  ^true

]

{ #category : #aplicacion }
Viaje >> desocuparCuposConCantidad: cantP yFecha: unaFecha [
^self subclassResponsibility 
]

{ #category : #visualizadores }
Viaje >> getActivo [
  ^activo

]

{ #category : #visualizadores }
Viaje >> getCostoPorPersona [
^costoPorPersona 
]

{ #category : #visualizadores }
Viaje >> getImpuesto [
^impuesto 
]

{ #category : #visualizadores }
Viaje >> getNombre [
	^nombre 
	
]

{ #category : #visualizadores }
Viaje >> getValorPlus [ 
^valorPlus 
]

{ #category : #inicializadores }
Viaje >> inicializarConNombre: unNombre yCostoPorPersona: unCosto yImpuesto: unImpuesto yValorPlus: unValorPlus [
	nombre := unNombre .
	costoPorPersona := unCosto .
	impuesto := unImpuesto .
	valorPlus := unValorPlus.
	activo:=true.
  
]

{ #category : #aplicacion }
Viaje >> ocuparCuposConCantidad:unaCantPers yFecha: unaFecha [
^self subclassResponsibility 
]

{ #category : #modificadores }
Viaje >> setCostoPorPersona: unCosto [
costoPorPersona := unCosto.  
]

{ #category : #modificadores }
Viaje >> setImpuesto: unImpuesto [
impuesto := unImpuesto. 
]

{ #category : #modificadores }
Viaje >> setValorPlus: unValorPlus [ 
valorPlus := unValorPlus. 
]

{ #category : #aplicacion }
Viaje >> verificarCupoConCantidadPersonas: cantP yFecha: unaFecha [
^self subclassResponsibility  
]

{ #category : #aplicacion }
Viaje >> verificarDisponibilidadViajeConCantPersonas: cantP yFecha: unaFecha [
  |ret|
  ret := false.
  activo ifTrue: [ 
	ret := self verificarCupoConCantidadPersonas: cantP yFecha: unaFecha 
	 ].
  ^ret.
]

{ #category : #aplicacion }
Viaje >> verificarEntreFechasConFecha1: unaFecha yFecha2: otraFecha [
	^self subclassResponsibility .
]

{ #category : #aplicacion }
Viaje >> verificarViaje:unNombre [
	^nombre = unNombre
	
]

{ #category : #aplicacion }
Viaje >> verificarViajeOrganizado [
  ^false

]

{ #category : #aplicacion }
Viaje >> verificarViajeRealizado [ 
^self subclassResponsibility 

]
