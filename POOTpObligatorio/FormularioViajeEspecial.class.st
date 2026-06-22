Class {
	#name : #FormularioViajeEspecial,
	#superclass : #BorderedMorph,
	#instVars : [
		'empresa',
		'campoNombre',
		'campoCosto',
		'campoImpuesto',
		'campoValorPlus',
		'campoCiudad',
		'campoDisponibilidad',
		'botonCrear',
		'botonCerrar'
	],
	#category : #POOTpObligatorio
}

{ #category : #constructor }
FormularioViajeEspecial class >> crearConEmpresa: unaEmpresa [

	| formulario |
	formulario := self new.
	formulario iniConEmpresa: unaEmpresa.
	^formulario 
]

{ #category : #aplicacion }
FormularioViajeEspecial >> crearViajeEspecial [

	| nombre costo impuesto valorPlus ciudad disponibilidad fechaSalida fechaRegreso exito |
	nombre := campoNombre contents.
	costo := campoCosto contents.
	impuesto := campoImpuesto contents.
	valorPlus := campoValorPlus contents.
	ciudad := campoCiudad contents.
	disponibilidad := campoDisponibilidad contents.

	(nombre isEmpty or: [ ciudad isEmpty ]) ifTrue: [ 
		UIManager default alert: 'Hay campos vacíos'.
		^ nil ].

	fechaSalida := UIManager default request:
		               'Ingrese fecha salida (mm/dd/yyyy)'.
	fechaSalida ifNil: [ ^ nil ].

	fechaRegreso := UIManager default request:
		                'Ingrese fecha regreso (mm/dd/yyyy)'.
	fechaRegreso ifNil: [ ^ nil ].

	exito := empresa
		         realizarAltaViajeEspecialConNombre: nombre
		         yCostoPorPersona: costo asNumber
		         yImpuesto: impuesto asNumber
		         yValorPlus: valorPlus asNumber
		         yCiudad: ciudad
		         yFechaSalida: (Date readFrom: fechaSalida readStream)
		         yFechaRegreso: (Date readFrom: fechaRegreso readStream)
		         yDisponibilidad: disponibilidad asNumber.

	exito
		ifTrue: [ 
			UIManager default inform: 'Viaje creado correctamente'.
			self delete ]
		ifFalse: [ UIManager default alert: 'No se pudo crear el viaje' ]
]

{ #category : #inicializadores }
FormularioViajeEspecial >> iniConEmpresa: unaEmpresa [
empresa := unaEmpresa. 
]

{ #category : #inicializadores }
FormularioViajeEspecial >> initialize [

	| origen titulo nombre costo impuesto valorPlus ciudad disponibilidad |
	super initialize.

	self extent: 360 @ 320.
	self color: Color veryLightGray.
	self borderWidth: 2.

	origen := self innerBounds origin.

	titulo := StringMorph contents: 'Alta Viaje Especial'.
	titulo position: origen + (100 @ 10).
	self addMorph: titulo.

	nombre := StringMorph contents: 'Nombre:'.
	nombre position: origen + (20 @ 50).
	self addMorph: nombre.

	campoNombre := TextMorph new.
	campoNombre position: origen + (150 @ 50).
	campoNombre extent: 160 @ 20.
	campoNombre backgroundColor: Color white.
	campoNombre borderWidth: 1.
	self addMorph: campoNombre.

	"Costo"
	costo := StringMorph contents: 'Costo por persona:'.
	costo position: origen + (20 @ 80).
	self addMorph: costo.

	campoCosto := TextMorph new.
	campoCosto position: origen + (150 @ 80).
	campoCosto extent: 160 @ 20.
	campoCosto backgroundColor: Color white.
	campoCosto borderWidth: 1.
	self addMorph: campoCosto.

	"Impuesto"
	impuesto := StringMorph contents: 'Impuesto:'.
	impuesto position: origen + (20 @ 110).
	self addMorph: impuesto.

	campoImpuesto := TextMorph new.
	campoImpuesto position: origen + (150 @ 110).
	campoImpuesto extent: 160 @ 20.
	campoImpuesto backgroundColor: Color white.
	campoImpuesto borderWidth: 1.
	self addMorph: campoImpuesto.

	valorPlus := StringMorph contents: 'Valor Plus:'.
	valorPlus position: origen + (20 @ 140).
	self addMorph: valorPlus.

	campoValorPlus := TextMorph new.
	campoValorPlus position: origen + (150 @ 140).
	campoValorPlus extent: 160 @ 20.
	campoValorPlus backgroundColor: Color white.
	campoValorPlus borderWidth: 1.
	self addMorph: campoValorPlus.

	ciudad := StringMorph contents: 'Ciudad:'.
	ciudad position: origen + (20 @ 170).
	self addMorph: ciudad.

	campoCiudad := TextMorph new.
	campoCiudad position: origen + (150 @ 170).
	campoCiudad extent: 160 @ 20.
	campoCiudad backgroundColor: Color white.
	campoCiudad borderWidth: 1.
	self addMorph: campoCiudad.

	disponibilidad := StringMorph contents: 'Disponibilidad:'.
	disponibilidad position: origen + (20 @ 200).
	self addMorph: disponibilidad.

	campoDisponibilidad := TextMorph new.
	campoDisponibilidad position: origen + (150 @ 200).
	campoDisponibilidad extent: 160 @ 20.
	campoDisponibilidad backgroundColor: Color white.
	campoDisponibilidad borderWidth: 1.
	self addMorph: campoDisponibilidad.

	botonCrear := Boton new.
	botonCrear label: 'Crear Viaje'.
	botonCrear position: origen + (60 @ 250).
	botonCrear mouseAction: [ self crearViajeEspecial ].
	self addMorph: botonCrear.

	botonCerrar := Boton new.
	botonCerrar label: 'Cerrar'.
	botonCerrar position: origen + (200 @ 250).
	botonCerrar mouseAction: [ self delete ].
	self addMorph: botonCerrar
]
