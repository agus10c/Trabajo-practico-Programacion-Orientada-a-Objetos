"
Clase  TuplaFechaSalCupo de trabajo practico obligatorio que corresponde a una tupla de una fecha de salida con su respectivo cupo

ViajeOrganizado -----(1...*)-> TuplaFechaSalCupo

    Instance Variables
	cupo:		<Object>
	fechaSalida:		<Object>



"
Class {
	#name : #FechaSalidaCupo,
	#superclass : #Object,
	#instVars : [
		'fechaSalida',
		'cupo'
	],
	#category : #POOTpObligatorio
}

{ #category : #constructor }
FechaSalidaCupo class >> crearConFechaSalida:unaFecha yCupo: unCupo [
	|unaTupla|
	unaTupla:=self new.
	unaTupla inicializarConFechaSalida: unaFecha yCupo:unCupo.
	^unaTupla 
]

{ #category : #modificadores }
FechaSalidaCupo >> cambiarFecha: unaFecha [
  fechaSalida := unaFecha. 

]

{ #category : #aplicacion }
FechaSalidaCupo >> desocupar: cantP [
  cupo := (cupo + cantP). 

]

{ #category : #visualizadores }
FechaSalidaCupo >> getCupo [
^cupo 

]

{ #category : #visualizadores }
FechaSalidaCupo >> getFechaSalida [
^fechaSalida 

]

{ #category : #aplicacion }
FechaSalidaCupo >> hayCupoParaCantidadPersonas: unaCantidad [
^(cupo >=unaCantidad)


]

{ #category : #inicializadores }
FechaSalidaCupo >> iniConFechaSalida: unaFecha cupo: unCupo [
  fechaSalida := unaFecha.
  cupo := unCupo.  
]

{ #category : #inicializadores }
FechaSalidaCupo >> inicializarConFechaSalida: unaFecha yCupo: unCupo [
	fechaSalida :=unaFecha.
	cupo:=unCupo.
]

{ #category : #aplicacion }
FechaSalidaCupo >> ocupar: cantP [
  cupo := (cupo - cantP). 

]

{ #category : #modificadores }
FechaSalidaCupo >> setCupo: nuevoCupo [
cupo :=nuevoCupo 
]

{ #category : #aplicacion }
FechaSalidaCupo >> verificarFechaPasada [ 
 ^(fechaSalida > (Date today))

]

{ #category : #aplicacion }
FechaSalidaCupo >> verificarFechaSalida: unaFecha [
^fechaSalida = unaFecha 

]
