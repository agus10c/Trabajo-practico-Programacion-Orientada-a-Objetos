Class {
	#name : #VentanaClientes,
	#superclass : #SystemWindow,
	#instVars : [
		'empresa',
		'campoApellido',
		'campoDni',
		'campoCiudad',
		'campoContacto'
	],
	#category : #POOTpObligatorio
}

{ #category : #constructor }
VentanaClientes class >> crearConEmpresa: unaEmpresa [
    |unaVentana|
    unaVentana :=  self new.
	 unaVentana iniConEmpresa: unaEmpresa.
	^unaVentana 	
]

{ #category : #aplicacion }
VentanaClientes >> abrir [
 self openInWorld.
]

{ #category : #aplicacion }
VentanaClientes >> agregarClienteNuevo [
|apellido dni ciudad contacto|
apellido := campoApellido contents asString.
dni := campoDni contents asString.
ciudad := campoCiudad contents asString.
contacto := campoContacto contents asString.
(apellido isEmpty or: [ dni isEmpty or: [
    ciudad isEmpty or: [
    contacto isEmpty ]]])
        ifTrue: [
            UIManager default alert: 'Hay campos sin completar'.
            ^self
        ].
(empresa agregarCliente:
        (Cliente crearConApellido: apellido
            yDni: dni asNumber
            yCiudadDeResidencia: ciudad
            yDatosDeContacto: contacto)
)ifTrue: [ 
	self changed: #listaClientes.
	UIManager default inform: 'Nuevo Cliente agregado correctamente'
 ] ifFalse: [ UIManager default alert: 'Error al intentar agregar nuevo Cliente']

    
]

{ #category : #aplicacion }
VentanaClientes >> cerrar [ 
	"minimiza la ventana"
	self collapse.
]

{ #category : #inicializadores }
VentanaClientes >> iniConEmpresa: unaEmpresa [
	empresa := unaEmpresa. 
	self changed: #listaClientes. "avisa que el aspecto listaContratos cambio"
]

{ #category : #inicializadores }
VentanaClientes >> initialize [

	| origen tituloClientes tituloVencer tituloFormulario apellido dni ciudad contacto listaClientes listaAVencer botonAgregar botonInicioDia |
	super initialize.

	self setLabel: 'Gestion de Clientes'.
	"Posición y tamaño de la ventana"
	self bounds: (100 @ 100 extent: 600 @ 400).
	"Origen del área interna"
	origen := self innerBounds origin.
	origen := origen + (10 @ 10).


	" LISTA DE CLIENTES"

	listaClientes := PluggableListMorph
		                 on: self
		                 list: #listaClientes
		                 selected: nil
		                 changeSelected: nil.

	listaClientes position: origen + (20 @ 30).
	listaClientes extent: 250 @ 150.

	self addMorph: listaClientes.

	" TITULOS"

	tituloClientes := StringMorph contents: 'Clientes'.
	tituloClientes position: origen + (20 @ 10).
	self addMorph: tituloClientes.

	tituloVencer := StringMorph contents:
		                'Clientes con contratos a vencer'.
	tituloVencer position: origen + (300 @ 10).
	self addMorph: tituloVencer.

	tituloFormulario := StringMorph contents: 'Nuevo Cliente'.
	tituloFormulario position: origen + (20 @ 210).
	self addMorph: tituloFormulario.

	" LISTA CLIENTES A VENCER"

	listaAVencer := PluggableListMorph
		                on: self
		                list: #listaClientesAVencer
		                selected: nil
		                changeSelected: nil.

	listaAVencer position: origen + (300 @ 30).
	listaAVencer extent: 250 @ 150.

	self addMorph: listaAVencer.

	"FORMULARIO PARA AGREGAR CLIENTES"
	apellido := StringMorph contents: 'Apellido:'.
	apellido position: origen + (20 @ 230).
	self addMorph: apellido.

	campoApellido := TextMorph new.
	campoApellido position: origen + (100 @ 230).
	campoApellido extent: 180 @ 20.
	campoApellido backgroundColor: Color white. "Color de fondo"
	campoApellido borderWidth: 1. "tamaño del borde del rectangulo"
	self addMorph: campoApellido.

	dni := StringMorph contents: 'DNI:'.
	dni position: origen + (20 @ 260).
	self addMorph: dni.

	campoDni := TextMorph new.
	campoDni position: origen + (100 @ 260).
	campoDni extent: 180 @ 20.
	campoDni backgroundColor: Color white.
	campoDni borderWidth: 1.
	self addMorph: campoDni.

	ciudad := StringMorph contents: 'Ciudad:'.
	ciudad position: origen + (20 @ 290).
	self addMorph: ciudad.

	campoCiudad := TextMorph new.
	campoCiudad position: origen + (100 @ 290).
	campoCiudad extent: 180 @ 20.
	campoCiudad backgroundColor: Color white.
	campoCiudad borderWidth: 1.
	self addMorph: campoCiudad.

	contacto := StringMorph contents: 'Contacto:'.
	contacto position: origen + (20 @ 320).
	self addMorph: contacto.

	campoContacto := TextMorph new.
	campoContacto position: origen + (100 @ 320).
	campoContacto extent: 180 @ 20.
	campoContacto backgroundColor: Color white.
	campoContacto borderWidth: 1.
	self addMorph: campoContacto.

	"BOTONES"

	botonAgregar := Boton new.
	botonAgregar label: 'Agregar Cliente'.
	botonAgregar position: origen + (300 @ 260).
	self addMorph: botonAgregar.

	botonInicioDia := Boton new.
	botonInicioDia label: 'Inicio del dia'.
	botonInicioDia position: origen + (300 @ 310).
	self addMorph: botonInicioDia.

	"ACCIONES DE BOTONES"

	botonAgregar mouseAction: [ self agregarClienteNuevo ].

	botonInicioDia mouseAction: [ self changed: #listaClientesAVencer ]
]

{ #category : #aplicacion }
VentanaClientes >> listaClientes [
empresa ifNotNil: [
	^ empresa getColClientes collect: [:c | c getApellido , ' - ' , c getDni asString].  
	] ifNil: [ ^OrderedCollection new ]
 
]

{ #category : #aplicacion }
VentanaClientes >> listaClientesAVencer [
 | clientes |
 empresa ifNotNil: [ 
	clientes := empresa realizarInicioDelDia.

 	^ clientes collect: [:c |
        c getApellido , ' - ' , c getDni asString
	 ].
] ifNil: [ ^OrderedCollection new ]	
 
]
