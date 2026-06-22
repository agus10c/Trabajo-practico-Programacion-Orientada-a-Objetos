Class {
	#name : #Boton,
	#superclass : #SimpleButtonMorph,
	#instVars : [
		'bloque',
		'bloqueAction'
	],
	#category : #POOTpObligatorio
}

{ #category : #constructor }
Boton class >> crearBotonColor: uncolor posicion: unapos dimension: unadim etiqueta: unaetiqueta [
|boton|
boton:= self new.
boton iniciarBotonColor: uncolor posicion: unapos dimension: unadim etiqueta: unaetiqueta.
^boton.
]

{ #category : #iniciar }
Boton >> iniciarBotonColor: uncolor posicion: unapos dimension: unadim etiqueta: unaetiqueta [

self color: uncolor.
self position: unapos.
self label: unaetiqueta .
self bounds:(self position extent: unadim).
]

{ #category : #'event handling' }
Boton >> mouseAction: unBloque [
^bloqueAction := unBloque.
]

{ #category : #'event handling' }
Boton >> mouseUp: unEvento [
super mouseUp: unEvento.
bloqueAction value.
]

{ #category : #initialization }
Boton >> setColor: unC [
color := unC.
]
