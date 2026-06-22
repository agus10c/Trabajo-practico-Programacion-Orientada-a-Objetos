Class {
	#name : #VentanaContratos,
	#superclass : #SystemWindow,
	#instVars : [
		'empresa',
		'campoDni',
		'campoViaje',
		'campoPersonas',
		'campoCuotas'
	],
	#category : #POOTpObligatorio
}

{ #category : #constructor }
VentanaContratos class >> crearConEmpresa: unaEmpresa [
    |unaVentana|
    unaVentana :=  self new.
	 unaVentana iniConEmpresa: unaEmpresa.
	^unaVentana 	
]

{ #category : #aplicacion }
VentanaContratos >> abrir [
 self openInWorld.
]

{ #category : #aplicacion }
VentanaContratos >> agregarExcursion [

	| nomExcursion cantPersonas nroContrato  exito |
	nroContrato := UIManager default request:
		               'Ingrese numero de contrato'.

	nroContrato ifNil: [ ^ self ].

	nomExcursion := UIManager default request:
		                'Ingrese nombre de la excursion'.

	cantPersonas := UIManager default request:
		                'Ingrese cantidad de personas'.
	nomExcursion ifNotNil: [ 
		cantPersonas ifNotNil: [ 
			exito := empresa
				         agregarExcursionOpcionalAContratoConNomExcursion:
				         nomExcursion
				         yCantPersonas: (cantPersonas asNumber)
				         yNroContrato: (nroContrato asNumber).
			exito
				ifTrue: [ 
				UIManager default inform: 'Exito al agregar la excursion.' ]
				ifFalse: [ 
				UIManager default alert: 'No se pudo agregar la excursion.' ] ] ]
]

{ #category : #aplicacion }
VentanaContratos >> cancelar [

	| nroContrato exito |
	nroContrato := UIManager default request:'Ingrese numero de contrato'.

	nroContrato ifNil: [ ^ self ].

	exito := empresa cancelarContrato: nroContrato asNumber.

	exito
		ifTrue: [ 
		UIManager default inform: 'Contrato cancelado correctamente' ]
		ifFalse: [ 
		UIManager default alert: 'No se pudo cancelar el contrato' ]
]

{ #category : #aplicacion }
VentanaContratos >> cerrar [ 
	"minimiza la ventana"
	self collapse.
]

{ #category : #aplicacion }
VentanaContratos >> efectivizar [

	| nroContrato exito |
	nroContrato := UIManager default request:
		               'Ingrese numero de contrato'.

	nroContrato ifNil: [ 
		UIManager default alert: 'Error Contrato no encontrado'.
		^ nil ].

	exito := empresa efectivizarContrato: nroContrato asNumber.

	exito
		ifTrue: [ 
		UIManager default inform: 'Contrato efectivizado correctamente' ]
		ifFalse: [ 
		UIManager default alert: 'No se pudo efectivizar el contrato' ]
]

{ #category : #aplicacion }
VentanaContratos >> generarContrato [

	| dni viaje personas cuotas fecha pagarConMillas esFlexible |
	dni := campoDni contents asString trimBoth. "trimBoth elimina espacios de la cadena"
	viaje := campoViaje contents asString trimBoth.
	personas := campoPersonas contents asString trimBoth.
	cuotas := campoCuotas contents asString trimBoth.

	(dni isEmpty or: [ 
		 viaje isEmpty or: [ personas isEmpty or: [ cuotas isEmpty ] ] ]) 
		ifTrue: [ 
			UIManager default alert: 'Hay campos sin completar'.
			^ self ].

	fecha := UIManager default request: 'Ingrese fecha (mm/dd/yyyy)'.
	fecha ifNil: [ ^ self ].

	pagarConMillas := UIManager default confirm:
		                  '¿Desea pagar con millas?'.
	esFlexible := UIManager default confirm: '¿El contrato es flexible?'.

	empresa
		generarNuevoContratoConDni: dni asNumber 
		yNombreViaje: viaje
		yFechaSeleccionada: (Date readFrom: fecha readStream)
		yCantidadPersonas: personas asNumber 
		yCantCuotas: cuotas asNumber 
		yPagarConMillas: pagarConMillas
		yEsFlexible: esFlexible
]

{ #category : #inicializadores }
VentanaContratos >> iniConEmpresa: unaEmpresa [
	empresa := unaEmpresa. 
]

{ #category : #inicializadores }
VentanaContratos >> initialize [

| origen dni viaje personas cuotas
  botonNuevoContrato botonPagarCuotas botonAgregarExcursion botonVerInfo
 botonEfectivizar botonReprogramar botonCancelar|

super initialize.

origen := 20@20.

self setLabel: 'Gestion Contratos'.
self color: Color gray.
self extent: 650@350.

"Formulario para agregar clientes"

dni := StringMorph contents: 'DNI:'.
dni position: origen + (0@40).
self addMorph: dni.

viaje := StringMorph contents: 'Nombre Viaje:'.
viaje position: origen + (0@80).
self addMorph: viaje.


personas := StringMorph contents: 'Cantidad Personas:'.
personas position: origen + (0@120).
self addMorph: personas.

cuotas := StringMorph contents: 'Cantidad Cuotas:'.
cuotas position: origen + (0@160).
self addMorph: cuotas.

campoDni := TextMorph new.
campoDni position: origen + (150@40).
campoDni extent: 180@25.
campoDni backgroundColor: Color white.
campoDni borderWidth: 1.
self addMorph: campoDni.

campoViaje := TextMorph new.
campoViaje position: origen + (150@80).
campoViaje extent: 180@25.
campoViaje backgroundColor: Color white.
campoViaje borderWidth: 1.
self addMorph: campoViaje.

campoPersonas := TextMorph new.
campoPersonas position: origen + (150@120).
campoPersonas extent: 180@25.
campoPersonas backgroundColor: Color white.
campoPersonas borderWidth: 1.
self addMorph: campoPersonas.

campoCuotas := TextMorph new.
campoCuotas position: origen + (150@160).
campoCuotas extent: 180@25.
campoCuotas backgroundColor: Color white.
campoCuotas borderWidth: 1.
self addMorph: campoCuotas.

"BOTONES"

botonNuevoContrato := Boton new.
botonNuevoContrato label: 'Generar Contrato'.
botonNuevoContrato position: origen + (20@260).
botonNuevoContrato mouseAction: [ self generarContrato ].
self addMorph: botonNuevoContrato.

botonPagarCuotas := Boton new.
botonPagarCuotas label: 'Pagar Cuotas'.
botonPagarCuotas position: origen + (170@260).
botonPagarCuotas mouseAction: [ self pagarCuotas ].
self addMorph: botonPagarCuotas.

botonAgregarExcursion := Boton new.
botonAgregarExcursion label: 'Agregar Excursion'.
botonAgregarExcursion position: origen + (300@260).
botonAgregarExcursion mouseAction: [ self agregarExcursion ].
self addMorph: botonAgregarExcursion. 

botonVerInfo := Boton new.
botonVerInfo label: 'Ver Info Contrato'.
botonVerInfo position: origen + (470@260).
botonVerInfo mouseAction: [ self verInfoContrato ].
self addMorph: botonVerInfo.

"Boton efectivizar contrato"
botonEfectivizar := Boton new.
botonEfectivizar label: 'Efectivizar Contrato'.
botonEfectivizar position: origen + (0@290).
botonEfectivizar mouseAction: [ self efectivizar ].
self addMorph: botonEfectivizar.

"Boton cancelar contrato"
botonCancelar := Boton new.
botonCancelar label: 'Cancelar Contrato'.
botonCancelar position: origen + (170@290).
botonCancelar mouseAction: [ self cancelar ].
self addMorph: botonCancelar.

"Boton reprogramar contrato"
botonReprogramar := Boton new.
botonReprogramar label: 'Reprogramar Contrato'.
botonReprogramar position: origen + (340@290).
botonReprogramar mouseAction: [ self reprogramar ].
self addMorph: botonReprogramar.
]

{ #category : #aplicacion }
VentanaContratos >> listaContratos [
^ empresa ifNotNil: [ empresa getColContratos collect: [:c | 'Contrato ', c getNumeroContrato asString]  
	 ]ifNil: [ ^OrderedCollection new ]
  
]

{ #category : #aplicacion }
VentanaContratos >> pagarCuotas [

| cantCuotas nroContrato exito|
nroContrato := UIManager default request: 'Ingrese el Numero de Contrato'.
nroContrato ifNotNil: [ 
		cantCuotas := UIManager default request: 'Ingrese la cantidad de cuotas que desea pagar'.
		cantCuotas ifNotNil: [ 
		exito := empresa pagarCuotasContratoConCantCuotasAPagar: (cantCuotas asNumber) yNroContrato: (nroContrato asNumber).
		exito ifTrue: [ UIManager default inform: 'Cuotas pagadas correctamente.' ]
		ifFalse: [ UIManager default alert: 'ERROR no se pudo realizar el pago.' ].
		]
	]



]

{ #category : #aplicacion }
VentanaContratos >> reprogramar [

| nroContrato fecha nuevaFecha exito |

nroContrato := UIManager default request: 'Ingrese numero de contrato'.
nroContrato ifNil: [ ^self ].

fecha := UIManager default request: 'Ingrese nueva fecha (mm/dd/yyyy)'.
fecha ifNil: [ ^self ].

nuevaFecha := Date readFrom: fecha readStream.

exito := empresa reprogramarFecha: (nroContrato asNumber) conNuevaFecha: nuevaFecha.

exito
	ifTrue: [ UIManager default inform: 'Contrato reprogramado correctamente'. ]
	ifFalse: [ UIManager default alert: 'No se pudo reprogramar el contrato'. ].
]

{ #category : #aplicacion }
VentanaContratos >> verInfoContrato [

	| nroContrato contrato ventana texto botonCerrar titulo |
	nroContrato := UIManager default request:
		               'Ingrese numero de contrato'.

	nroContrato ifNil: [ ^ self ].

	contrato := empresa buscarContratoConNumero: nroContrato asNumber.

	contrato
		ifNil: [ UIManager default alert: 'Contrato no encontrado' ]
		ifNotNil: [ 
			ventana := BorderedMorph new.
			ventana extent: 420 @ 320.
			ventana color: Color veryLightGray.
			ventana borderWidth: 2.

			titulo := StringMorph contents: 'Informacion de Contrato'.
			titulo position: 110 @ 10.
			ventana addMorph: titulo.

			texto := TextMorph new.
			texto contents:
				'Contrato N°: ' , contrato getNumeroContrato asString , String cr
				, 'Fecha de contrato: ' , contrato getFechaContrato asString
				, String cr , 'Viaje: ' , contrato getViajeContratado getNombre
				, String cr , 'Fecha de viaje seleccionada: '
				, contrato getFechaViajeSeleccionada asString , String cr
				, 'Personas: ' , contrato getCantidadPersonas asString , String cr
				, 'Excursiones contratadas: '
				, contrato getExcursionesContratadas size asString , String cr
				, 'Cuotas sin pagar: '
				, contrato getColCuotasSinPagar size asString , String cr
				, 'Cuotas pagadas: ' , contrato getColCuotasPagadas size asString
				, String cr , 'Estado: ' , contrato getEstado asString , String cr
				, 'Es flexible: ' , contrato getEsFlexible asString , String cr
				, 'Valor total: ' , contrato getValorTotal asString , String cr
				, 'Valor reembolso: ' , contrato getReembolso asString.

			texto position: 10 @ 40.
			texto extent: 400 @ 220.
			ventana addMorph: texto.

			botonCerrar := Boton new.
			botonCerrar label: 'Cerrar'.
			botonCerrar position: 160 @ 270.
			botonCerrar mouseAction: [ ventana delete ].
			ventana addMorph: botonCerrar.

			ventana openInWorld ]
]
