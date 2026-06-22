"
Construya la clase Cliente que registra la información del cliente: Dni, nombre y apellido, teléfono y datos de la tarjeta de crédito y fecha de vencimiento (por ejemplo VISA, 05/2014).
*Defina protocolos visualizadores, modificadores y de aplicación.
*Construya los mensajes para visualizar y modificar sus variables de instancia.
*Construya el mensaje verificarVencimiento. (que devolverá cuanto tiempo falta en días para que venza la tarjeta). Utilice el system browser para encontrar que clase y operaciones se pueden realizar con fechas.
"
Class {
	#name : #Cliente,
	#superclass : #Object,
	#instVars : [
		'apellido',
		'dni',
		'ciudadDeResidencia',
		'datosDeContacto',
		'colContratos'
	],
	#classInstVars : [
		'apellido',
		'dni',
		'ciudadDeResidencia',
		'datosDeContacto',
		'colContratos'
	],
	#category : #POOTpObligatorio
}

{ #category : #constructor }
Cliente class >> crearConApellido: suAp yDni: suDNI yCiudadDeResidencia: suCr yDatosDeContacto: susDatos [
	|unCliente|
	unCliente := self new.
	unCliente iniConApellido:suAp yDni:suDNI yCiudadDeResidencia:suCr yDatosDeContacto:susDatos.
	^unCliente  
]

{ #category : #constructor }
Cliente class >> crearConApellido: suAp yDni: suDNI yCiudadDeResidencia: suCr yDatosDeContacto: susDatos yColContratos:unaCol [
	|unCliente|
	unCliente := self new.
	unCliente iniConApellido:suAp yDni:suDNI yCiudadDeResidencia:suCr yDatosDeContacto:susDatos yColContratos: unaCol.
	^unCliente  
]

{ #category : #aplicacion }
Cliente >> alctualizarFechaContratosEnClienteConFecha: unaFecha yFechaNueva: fechaNueva [
colContratos do: [ :contrato | (contrato verificarFechaSeleccionadaConUnaFecha: unaFecha) ifTrue: [contrato actualizarFechaSeleccionada: fechaNueva]]
]

{ #category : #aplicacion }
Cliente >> buscarContratoEnCliente: unNumero [
"Método que busca un contrato en la colContratos con su numero id"
	^colContratos detect: [ :cadaContrato| (cadaContrato verificarConNumero:unNumero)] 	ifNone:[nil].
	
]

{ #category : #aplicacion }
Cliente >> completarEfectivizacion: unContrato [
^unContrato efectivizar. 
]

{ #category : #visualizadores }
Cliente >> esFrecuente [ 
    ^false 
 	
]

{ #category : #aplicacion }
Cliente >> generarContratoConViaje: unViaje yFechaSeleccionada: feViSe yCantidadPersonas: cantP yCantCuotas: cantCuot yPagarConMillas: pm yEsFlexible: flex [
"Método que genera un un Contrato"
	|unCosto unContrato descuento|
	unCosto:=unViaje calcularCostoConCantPersonas: cantP.
	(pm) ifTrue: [ 
		descuento := (unCosto/10). 
		"Cada milla equivale a $1"
		(self verificarPagoConMillas:descuento) ifTrue: [ 	
			unCosto := (unCosto - descuento).  
			 ]
		 ].
	unContrato := Contrato crearConUnViaje: unViaje yFechaSeleccionada:feViSe yCantPersonas:cantP yCantCuotas: cantCuot yValorTotlal:unCosto yEsFlexible: flex.
	colContratos add: unContrato. 	
]

{ #category : #visualizadores }
Cliente >> getApellido [
^apellido 
]

{ #category : #visualizadores }
Cliente >> getCiudadDeResidencia [
^ciudadDeResidencia 
]

{ #category : #visualizadores }
Cliente >> getColContratos [
^colContratos 
]

{ #category : #visualizadores }
Cliente >> getDatosDeContacto [
^datosDeContacto 
]

{ #category : #visualizadores }
Cliente >> getDni [
^dni
]

{ #category : #aplicacion }
Cliente >> hacerFrecuente [
  |unViajeroFrecuente|
  unViajeroFrecuente := ViajeroFrecuente crearConApellido: apellido yDNI: dni yCiudadDeResidencia: ciudadDeResidencia yDatosDeContacto: datosDeContacto yColContratos: colContratos yMillas: 0.
  ^unViajeroFrecuente  

]

{ #category : #inicializadores }
Cliente >> iniConApellido: ap yDni: suDni yCiudadDeResidencia: cr yDatosDeContacto: dc [ 
  apellido := ap.
  dni := suDni.
  ciudadDeResidencia := cr.
  datosDeContacto := dc.
  colContratos := OrderedCollection new.
]

{ #category : #inicializadores }
Cliente >> iniConApellido: suAp yDni: suDNI yCiudadDeResidencia: suCr yDatosDeContacto: susDatos yColContratos: susContratos [
  apellido := suAp.
  dni := suDNI.
  ciudadDeResidencia := suCr.
  datosDeContacto := susDatos.
  colContratos := susContratos.  
]

{ #category : #aplicacion }
Cliente >> realizarCancelacion: nroContrato [
|unContrato|
 unContrato := self buscarContratoEnCliente: nroContrato. 	
 ^unContrato cancelar: self. 
 

]

{ #category : #aplicacion }
Cliente >> realizarEfectivizacion: nroContrato [

	| unContrato exito |
	exito := false.
	unContrato := self buscarContratoEnCliente: nroContrato.
	unContrato ifNotNil: [ 
		exito := self completarEfectivizacion: unContrato.
		 ].
	^ exito
]

{ #category : #aplicacion }
Cliente >> reembolsar: unValor [
  ^true  
 

]

{ #category : #modificadores }
Cliente >> setApellido: unApellido [
apellido := unApellido 
]

{ #category : #modificadores }
Cliente >> setCiudadDeResidencia: unaCiudad [
ciudadDeResidencia := unaCiudad.  
]

{ #category : #modificadores }
Cliente >> setDatosDeContacto: nuevosDatos [
datosDeContacto := nuevosDatos  
]

{ #category : #aplicacion }
Cliente >> tieneContratoAVencer [
  |rta| 
  rta:= false.
  colContratos ifNotNil: [rta := colContratos anySatisfy:[:cadaContrato | cadaContrato verificarContratoAVencer ]].
  ^rta


]

{ #category : #visualizadores }
Cliente >> toStringColContratos [
   |cad|
	cad := '[ '. 
	colContratos do: [:contrato|
    cad := cad , (contrato getNumeroContrato) asString, ', '.
].
cad := cad, ' ]'.
	^cad
]

{ #category : #aplicacion }
Cliente >> verificarConDNI: dniCliente [
 ^dniCliente = dni.

]

{ #category : #aplicacion }
Cliente >> verificarContratoEnCliente: nroContrato [
  ^colContratos anySatisfy: [:contrato | contrato verificarConNumero: nroContrato].

]

{ #category : #aplicacion }
Cliente >> verificarFrecuente [
  |ret|
  ret := colContratos anySatisfy: [:contrato | contrato verificarViajeOrgEnAño: Date today].
  ^ret

]

{ #category : #aplicacion }
Cliente >> verificarPagoConMillas:descuento [
  ^false

]
