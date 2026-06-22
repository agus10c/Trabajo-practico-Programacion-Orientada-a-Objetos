Class {
	#name : #Etapa,
	#superclass : #Object,
	#instVars : [
		'diaLlegada',
		'cantDiasPermanencia',
		'hotel',
		'tipoPension',
		'listaActividades'
	],
	#category : #POOTpObligatorio
}

{ #category : #constructor }
Etapa class >> crearConDiaLlegada: unDia yCantDiasPermanencia: unaCantDias yHotel: unHotel  yTipoPension: unTipoDePension  yListaActividades: unaListaDeActividades [
	|unaEtapa|
	unaEtapa := self new.
	unaEtapa iniConDiaLlegada: unDia yCantDiasPermanencia: unaCantDias yHotel: unHotel  yTipoPension: unTipoDePension  yListaActividades: unaListaDeActividades.
	^unaEtapa 
]

{ #category : #visualizadores }
Etapa >> getCantDiasPermanencia [
	^cantDiasPermanencia 
	
]

{ #category : #visualizadores }
Etapa >> getDiaLlegada [
	^diaLlegada 
	
]

{ #category : #visualizadores }
Etapa >> getHotel [
	^hotel
]

{ #category : #visualizadores }
Etapa >> getListaActividades [ 
	^listaActividades 
	
]

{ #category : #visualizadores }
Etapa >> getTipoPension [
	^tipoPension 
	
]

{ #category : #inicializadores }
Etapa >> iniConDiaLlegada: unDia yCantDiasPermanencia: unaCantDias yHotel: unHotel  yTipoPension: unTipoDePension  yListaActividades: unaListaDeActividades [
	diaLlegada := unDia.
	cantDiasPermanencia := unaCantDias.
	hotel := unHotel.
	tipoPension := unTipoDePension.
	listaActividades := unaListaDeActividades.     
]

{ #category : #modificadores }
Etapa >> setCantDiasPermanencia: unaCant [
	cantDiasPermanencia := unaCant. 
]

{ #category : #modificadores }
Etapa >> setHotel: nuevoHotel [
	hotel := nuevoHotel. 
]

{ #category : #modificadores }
Etapa >> setListaDeActividades: unaLista [
	listaActividades := unaLista. 
]

{ #category : #modificadores }
Etapa >> setTipoPension: unTipo [
	tipoPension := unTipo.
	  
]
