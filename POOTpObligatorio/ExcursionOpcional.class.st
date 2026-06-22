"
Clase  TuplaExcOpValor de trabajo practico obligatorio que corresponde a una tupla de una excursion opcional con su respectivo valor por persona

ViajeOrganizado -----(1...*)-> TuplaExcOpValor
    Instance Variables
	excursionOpcional:		<Object>
	valor:		<Object>


"
Class {
	#name : #ExcursionOpcional,
	#superclass : #Object,
	#instVars : [
		'nombreDeExcursion',
		'valor'
	],
	#category : #POOTpObligatorio
}

{ #category : #constructor }
ExcursionOpcional class >> crearConNombre: nomExc yValor:unValor [
	|unaTupla|
	unaTupla :=self new.
	unaTupla iniConNombreDeExcursion: nomExc yValor: unValor.
	^unaTupla 
]

{ #category : #visualizadores }
ExcursionOpcional >> getNombreDeExcursion [
^nombreDeExcursion 

]

{ #category : #visualizadores }
ExcursionOpcional >> getValor [
^valor 

]

{ #category : #inicializadores }
ExcursionOpcional >> iniConNombreDeExcursion: unNombre yValor:unValor [
	nombreDeExcursion := unNombre.
	valor :=unValor 
]

{ #category : #modificadores }
ExcursionOpcional >> setValor: nuevoValor [
	valor := nuevoValor.
	 
]

{ #category : #aplicacion }
ExcursionOpcional >> verificarExcursionConNombre: nomExcursion [
	^nomExcursion = nombreDeExcursion 
]
