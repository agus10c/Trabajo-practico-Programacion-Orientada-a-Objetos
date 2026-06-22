"
Clase ViajeroFrecuente de trabajo Obligatorio.

Instance Variables
	millas:		<Object>


"
Class {
	#name : #ViajeroFrecuente,
	#superclass : #Cliente,
	#instVars : [
		'millas'
	],
	#category : #POOTpObligatorio
}

{ #category : #constructor }
ViajeroFrecuente class >> crearConApellido: suApellido yDNI: suDNI yCiudadDeResidencia: suCiudad yDatosDeContacto: dc yColContratos: unaColContratos yMillas: susMillas [
	|unViajeroFrecuente|
	unViajeroFrecuente := self new.
	unViajeroFrecuente inicializarConApellido: suApellido yDni: suDNI yCiudadDeResidencia:suCiudad  		yDatosDeContacto: dc yColContratos: unaColContratos.
	unViajeroFrecuente inicializarConMillas:susMillas.
	^unViajeroFrecuente 

]

{ #category : #constructor }
ViajeroFrecuente class >> crearConApellido: suApellido yDNI: suDNI yCiudadDeResidencia: suCiudad yDatosDeContacto: dc yMillas: susMillas [
	|unViajeroFrecuente|
	unViajeroFrecuente := self new.
	unViajeroFrecuente iniConApellido: suApellido yDni: suDNI yCiudadDeResidencia:suCiudad  		yDatosDeContacto: dc.
	unViajeroFrecuente inicializarConMillas:susMillas.
	^unViajeroFrecuente 

]

{ #category : #aplicacion }
ViajeroFrecuente >> completarEfectivizacion: unContrato [
  |unValor|
  unValor := unContrato obtenerValorViaje.
  millas := millas + unValor/10. 
  super completarEfectivizacion: unContrato.

]

{ #category : #visualizadores }
ViajeroFrecuente >> esFrecuente [ 
	^true
]

{ #category : #visualizadores }
ViajeroFrecuente >> getMillas [
^millas
]

{ #category : #inicializadores }
ViajeroFrecuente >> inicializarConMillas: m [
 	millas := m.

]

{ #category : #aplicacion }
ViajeroFrecuente >> reembolsar: unValor [
  millas := millas + unValor.
  ^true.  

]

{ #category : #modificadores }
ViajeroFrecuente >> setMillas: unasMillas [
millas := unasMillas. 
]

{ #category : #aplicacion }
ViajeroFrecuente >> verificarPagoConMillas:descuento [
  ^(millas>=descuento)  
  


]
