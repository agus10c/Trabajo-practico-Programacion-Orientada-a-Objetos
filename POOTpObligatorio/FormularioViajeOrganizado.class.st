Class {
	#name : #FormularioViajeOrganizado,
	#superclass : #BorderedMorph,
	#instVars : [
		'empresa',
		'campoNombre',
		'campoCosto',
		'campoImpuesto',
		'campoValorPlus',
		'campoDiasDeDuracion',
		'botonCrear',
		'botonCerrar'
	],
	#category : #POOTpObligatorio
}

{ #category : #constructor }
FormularioViajeOrganizado class >> crearConEmpresa: unaEmpresa [

	| formulario |
	formulario := self new.
	formulario iniConEmpresa: unaEmpresa.
	^formulario
]

{ #category : #aplicacion }
FormularioViajeOrganizado >> crearViajeOrganizado [

	| nombre costo impuesto valorPlus duracion tuplasFeCupos colExcOp colEtapas seguir fecha cupo nombreExc costoExc diaLlegada cantDias hotel pension actividades exito |
	nombre := campoNombre contents.
	costo := campoCosto contents.
	impuesto := campoImpuesto contents.
	valorPlus := campoValorPlus contents.
	duracion := campoDiasDeDuracion contents.
	(nombre isEmpty or: [ 
		 costo isEmpty or: [ 
			 impuesto isEmpty or: [ valorPlus isEmpty or: [ duracion isEmpty ] ] ] ]) 
		ifTrue: [ 
			UIManager default alert: 'Hay campos vacíos'.
			^ nil ].

	tuplasFeCupos := OrderedCollection new.
	colExcOp := OrderedCollection new.
	colEtapas := OrderedCollection new.

	"Fechas de salida"
	seguir := true.

	[ seguir ] whileTrue: [ 
		fecha := UIManager default request:
			         'Ingrese fecha salida (mm/dd/yyyy)'.
		fecha ifNil: [ ^ nil ].

		cupo := UIManager default request: 'Ingrese cupo'.
		cupo ifNil: [ ^ nil ].
		tuplasFeCupos add: (FechaSalidaCupo
				 crearConFechaSalida: (Date readFrom: fecha readStream)
				 yCupo: cupo asNumber).

		seguir := UIManager default confirm:
			          '¿Desea agregar otra fecha de salida?' ].

	"Excursiones"
	seguir := UIManager default confirm: '¿Desea agregar excursiones?'.

	[ seguir ] whileTrue: [ 
		nombreExc := UIManager default request: 'Nombre excursión'.
		nombreExc ifNil: [ ^ nil ].
		costoExc := UIManager default request: 'Costo excursión'.
		costoExc ifNil: [ ^ nil ].

		colExcOp add:
			(ExcursionOpcional
				 crearConNombre: nombreExc
				 yValor: costoExc asNumber).

		seguir := UIManager default confirm: '¿Agregar otra excursión?' ].

	"Etapas"
	seguir := true.

	[ seguir ] whileTrue: [ 
		diaLlegada := (UIManager default request: 'Agregar etapa con Día llegada:') asNumber.
		diaLlegada ifNil: [ ^ nil ].
		cantDias := (UIManager default request: 'Cantidad días permanencia')
			            asNumber.
		cantDias ifNil: [ ^ nil ].
		hotel := UIManager default request: 'Hotel'.
		hotel ifNil: [ ^ nil ].
		pension := UIManager default request: 'Tipo pensión'.
		pension ifNil: [ ^ nil ].
		actividades := UIManager default request: 'Lista actividades'.
		actividades ifNil: [ ^ nil ].

		colEtapas add: (Etapa
				 crearConDiaLlegada: diaLlegada
				 yCantDiasPermanencia: cantDias
				 yHotel: hotel
				 yTipoPension: pension
				 yListaActividades: actividades).

		seguir := UIManager default confirm: '¿Agregar otra etapa?' ].

	exito := empresa
		         realizarAltaViajeOrganizadoConNombre: nombre
		         yCostoPorPersona: costo asNumber
		         yImpuesto: impuesto asNumber
		         yValorPlus: valorPlus asNumber
		         yCantDiasDuracion: duracion asNumber
		         yEtapas: colEtapas
		         yTuplasFechasSalidaCupos: tuplasFeCupos
		         yColExcursionesOpcionales: colExcOp.

	exito
		ifTrue: [ 
			UIManager default inform: 'Viaje organizado creado correctamente'.
			self delete ]
		ifFalse: [ UIManager default alert: 'No se pudo crear el viaje' ]
]

{ #category : #inicializadores }
FormularioViajeOrganizado >> iniConEmpresa: unaEmpresa [
empresa := unaEmpresa. 
]

{ #category : #inicializadores }
FormularioViajeOrganizado >> initialize [

| origen titulo nombre costo impuesto valorPlus duracion |

super initialize.

self extent: 380@260.
self color: Color veryLightGray.
self borderWidth: 2.

origen := self innerBounds origin.

"Titulo"
titulo := StringMorph contents: 'Alta Viaje Organizado'.
titulo position: origen + (110@10).
self addMorph: titulo.

"Nombre"
nombre := StringMorph contents: 'Nombre:'.
nombre position: origen + (20@50).
self addMorph: nombre.

campoNombre := TextMorph new.
campoNombre position: origen + (180@50).
campoNombre extent: 160@20.
campoNombre backgroundColor: Color white.
campoNombre borderWidth: 1.
self addMorph: campoNombre.

"Costo"
costo := StringMorph contents: 'Costo por persona:'.
costo position: origen + (20@80).
self addMorph: costo.

campoCosto := TextMorph new.
campoCosto position: origen + (180@80).
campoCosto extent: 160@20.
campoCosto backgroundColor: Color white.
campoCosto borderWidth: 1.
self addMorph: campoCosto.

"Impuesto"
impuesto := StringMorph contents: 'Impuesto:'.
impuesto position: origen + (20@110).
self addMorph: impuesto.

campoImpuesto := TextMorph new.
campoImpuesto position: origen + (180@110).
campoImpuesto extent: 160@20.
campoImpuesto backgroundColor: Color white.
campoImpuesto borderWidth: 1.
self addMorph: campoImpuesto.

"Valor Plus"
valorPlus := StringMorph contents: 'Valor Plus:'.
valorPlus position: origen + (20@140).
self addMorph: valorPlus.

campoValorPlus := TextMorph new.
campoValorPlus position: origen + (180@140).
campoValorPlus extent: 160@20.
campoValorPlus backgroundColor: Color white.
campoValorPlus borderWidth: 1.
self addMorph: campoValorPlus.

"Duracion"
duracion := StringMorph contents: 'Cant días duración:'.
duracion position: origen + (20@170).
self addMorph: duracion.

campoDiasDeDuracion := TextMorph new.
campoDiasDeDuracion position: origen + (180@170).
campoDiasDeDuracion extent: 160@20.
campoDiasDeDuracion backgroundColor: Color white.
campoDiasDeDuracion borderWidth: 1.
self addMorph: campoDiasDeDuracion.

"Boton crear"
botonCrear := Boton new.
botonCrear label: 'Crear Viaje'.
botonCrear position: origen + (70@210).
botonCrear mouseAction: [ self crearViajeOrganizado ].
self addMorph: botonCrear.

"Boton cerrar"
botonCerrar := Boton new.
botonCerrar label: 'Cerrar'.
botonCerrar position: origen + (220@210).
botonCerrar mouseAction: [ self delete ].
self addMorph: botonCerrar.
]
