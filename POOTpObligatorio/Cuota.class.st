"
Clase Cuota de trabajo practico obligatorio.
    Instance Variables
	fechaVencimiento:		<Object>
	valor:		<Object>


"
Class {
	#name : #Cuota,
	#superclass : #Object,
	#instVars : [
		'valor',
		'fechaVencimiento'
	],
	#category : #POOTpObligatorio
}

{ #category : #constructor }
Cuota class >> crearConValor: unValor yFechaVencimiento: unaFecha [
  |unaCuota|
  unaCuota := self new.
  unaCuota iniConValor: unValor yFechaVencimiento: unaFecha.
  ^unaCuota 


]

{ #category : #aplicacion }
Cuota >> aumentarValor: aumento [ 
	valor := valor + aumento. 
]

{ #category : #visualizadores }
Cuota >> getFechaVencimiento [
^fechaVencimiento 
]

{ #category : #visualizadores }
Cuota >> getValor [
^valor
]

{ #category : #inicializadores }
Cuota >> iniConValor: val yFechaVencimiento: fv [
  valor := val.
  fechaVencimiento := fv.
]

{ #category : #aplicacion }
Cuota >> verificarFechaVencimiento:unaFecha [
^fechaVencimiento =unaFecha 

]
