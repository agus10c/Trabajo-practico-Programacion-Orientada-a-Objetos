Class {
	#name : #Sistema,
	#superclass : #SystemWindow,
	#instVars : [
		'empresa',
		'ventanaClientes',
		'ventanaViajes',
		'ventanaContratos',
		'botonViajes',
		'botonContratos',
		'botonClientes',
		'botonInfoClientes',
		'botonInfoViajes'
	],
	#category : #POOTpObligatorio
}

{ #category : #constructor }
Sistema class >> abrirCon: unaEmpresa [
    ^ (self new iniConEmpresa: unaEmpresa ) abrir
]

{ #category : #aplicacion }
Sistema >> abrir [
 self openInWorld. "abre la ventana en el mundo Morphic"
]

{ #category : #aplicacion }
Sistema >> cerrar [ 
	"minimiza la ventana"
	self collapse.
]

{ #category : #aplicacion }
Sistema >> informacionDeClientes [

	| origen ventana texto morphTexto botonCerrar scroll |
	"Creo la ventana emergente"
	ventana := BorderedMorph new.
	ventana extent: 520 @ 380. "tamaño de la ventana"
	ventana color: Color veryLightGray.
	ventana borderWidth: 2.
	origen := ventana innerBounds origin.

	"Construyo el string con la info de todos los clientes"
	texto := String streamContents: [ :s | 
		         s
			         nextPutAll: 'Clientes';
			         cr.
		         s
			         nextPutAll: '-----------------------------';
			         cr.
		         empresa getColClientes do: [ :c | "Cada cliente: Apellido - DNI - Ciudad"
					(c esFrecuente) ifTrue: [  
						s nextPutAll: '(FRECUENTE )'.
					 ].
			
			         s nextPutAll: c getApellido asString.
			         s nextPutAll: ' | DNI: '.
			         s nextPutAll: c getDni asString.
			         s nextPutAll: ' | Ciudad: '.
			         s nextPutAll: c getCiudadDeResidencia asString.
			         s nextPutAll: ' | Datos de Contacto: '.
			         s nextPutAll: c getDatosDeContacto asString.
			         s nextPutAll: ' | Contratos: '.
			         s nextPutAll: c toStringColContratos.
			         s cr ] ].

	morphTexto := TextMorph new.
	morphTexto contents: texto.
	morphTexto wrapFlag: true. "hace que el texto baje si llega al borde de la ventana"
	morphTexto extent: 500 @ 320. "tamaño del área de texto"
	morphTexto position: 10 @ 40.

	scroll := ScrollPane new.
	scroll extent: 500 @ 300.
	scroll position: 10 @ 40.
	scroll scroller addMorph: morphTexto.

	ventana addMorph: scroll.
	ventana addMorph: morphTexto.

	"Botón cerrar"
	botonCerrar := Boton new.
	botonCerrar label: 'Cerrar'.
	botonCerrar position: origen + (200 @ 340).
	botonCerrar mouseAction: [ ventana delete ].
	ventana addMorph: botonCerrar.

	"Abrir en el world"
	ventana openInWorld
]

{ #category : #aplicacion }
Sistema >> informacionDeViaje [

	| ventana texto morphTexto botonCerrar scroll |
	ventana := BorderedMorph new.
	ventana extent: 600 @ 420.
	ventana color: Color veryLightGray.
	ventana borderWidth: 2.

	texto := String streamContents: [ :s | 
		         s
			         nextPutAll: 'Viajes';
			         cr.
		         s
			         nextPutAll: '-----------------------------';
			         cr.
		         empresa getColViajes do: [ :v | 
			         s nextPutAll: v getNombre asString.
			         s nextPutAll: ' | Costo por persona: '.
			         s nextPutAll: v getCostoPorPersona asString.
			         s nextPutAll: ' | Impuesto: '.
			         s nextPutAll: v getImpuesto asString.
			         s nextPutAll: ' | Activo: '.
			         s nextPutAll: v getActivo asString.

			         v verificarViajeOrganizado
				         ifTrue: [ 
					         s nextPutAll: ' | Dias de duracion: '.
					         s nextPutAll: v getCantDiasDuracion asString.

					         s nextPutAll: ' | FechasSalidaCupos: ['.
					         v getColFechasSalidaCupos do: [ :t | 
						         s nextPutAll: '(fecha: '.
						         s nextPutAll: t getFechaSalida mmddyyyy asString.
						         s nextPutAll: ' - cupo: '.
						         s nextPutAll: t getCupo asString.
						         s nextPutAll: ') ' ].
					         s nextPutAll: ']'.

					         s nextPutAll: ' | Excursiones opcionales: ['.
					         v obtenerExcursiones do: [ :e | 
						         s nextPutAll: '('.
						         s nextPutAll: e getNombreDeExcursion asString.
						         s nextPutAll: ' - valor: '.
						         s nextPutAll: e getValor asString.
						         s nextPutAll: ') ' ].
					         s
						         nextPutAll: ']';
						         cr.

					         s nextPutAll: ' | Etapas: ['.
					         v obtenerEtapas do: [ :et | 
						         s nextPutAll: '('.
						         s nextPutAll: 'diaLlegada: '.
						         s nextPutAll: et getDiaLlegada asString.
						         s nextPutAll: ', cantDias: '.
						         s nextPutAll: et getCantDiasPermanencia asString.
						         s nextPutAll: ', hotel: '.
						         s nextPutAll: et getHotel asString.
						         s nextPutAll: ', pension: '.
						         s nextPutAll: et getTipoPension asString.
						         s nextPutAll: ', actividades: '.
						         s nextPutAll: et getListaActividades asString.
						         s nextPutAll: ') ' ].
					         s
						         nextPutAll: ']';
						         cr.

					         s
						         nextPutAll: '-----------------------------';
						         cr ]
				         ifFalse: [ 
					         s nextPutAll: ' | Ciudad: '.
					         s
						         nextPutAll: v getCiudad asString;
						         cr.

					         s nextPutAll: ' | Fecha salida: '.
					         s
						         nextPutAll: v getFechaSalida mmddyyyy asString;
						         cr.

					         s nextPutAll: ' | Fecha regreso: '.
					         s
						         nextPutAll: v getFechaRegreso mmddyyyy asString;
						         cr.

					         s nextPutAll: ' | Disponibilidad: '.
					         s
						         nextPutAll: v getDisponibilidad asString;
						         cr.

					         s
						         nextPutAll: '-----------------------------';
						         cr ] ] ].

	morphTexto := TextMorph new.
	morphTexto contents: texto.
	morphTexto wrapFlag: true.
	morphTexto extent: 580 @ 360.
	morphTexto position: 10 @ 40.

	"ScrollPane"
	scroll := ScrollPane new.
	scroll extent: 580 @ 340.
	scroll position: 10 @ 40.
	scroll scroller addMorph: morphTexto.

	ventana addMorph: scroll.

	botonCerrar := Boton new.
	botonCerrar label: 'Cerrar'.
	botonCerrar position: 260 @ 380.
	botonCerrar mouseAction: [ ventana delete ].
	ventana addMorph: botonCerrar.

	ventana openInWorld
]

{ #category : #inicializadores }
Sistema >> iniConEmpresa: unaEmpresa [
	empresa := unaEmpresa. 
	"Crear ventanas secundarias"

	ventanaClientes := VentanaClientes crearConEmpresa: unaEmpresa.
	ventanaContratos := VentanaContratos crearConEmpresa: unaEmpresa.
	ventanaViajes := VentanaViajes crearConEmpresa: unaEmpresa.


	
]

{ #category : #inicializadores }
Sistema >> initialize [
|origen|
"Inicializo la superclase"
super initialize.

"Color y tamaño de la ventana"
self setLabel: 'Sistema'.
self color: Color lightGray.
"Posición y tamaño de la ventana"
self bounds: (50@50 extent: 220@260).

origen := self innerBounds origin. "devuelve la esquina superior izquierda del rectangulo interior de la ventana"
origen := origen + (40@20).
"Crear botones"
 botonClientes := Boton new.
 botonContratos := Boton new.
 botonViajes := Boton new.
 botonInfoClientes := Boton new.
 botonInfoViajes := Boton new.

 botonClientes position: origen + (20@20).
 botonContratos position: origen + (20@60).
 botonViajes position: origen + (20@100).
 botonInfoClientes position: origen + (20@140).
 botonInfoViajes position: origen + (20@180).

"Posiciones"
botonClientes position: origen + (20@20).
botonContratos position: origen + (20@60).
botonViajes position: origen + (20@100).

"Labels"
botonClientes label: 'Clientes'.
botonContratos label: 'Contratos'.
botonViajes label: 'Viajes'.
botonInfoClientes label: 'Info Clientes'.
botonInfoViajes label: 'Info Viajes'.

"agregar acciones a los botones"
botonClientes mouseAction: [ventanaClientes abrir.].
botonContratos mouseAction: [ventanaContratos abrir.].
botonViajes mouseAction: [ventanaViajes abrir.].
botonInfoClientes mouseAction: [ self informacionDeClientes ].
botonInfoViajes mouseAction: [ self informacionDeViaje ].

"Agregar botones a la ventana"
self addMorph: botonClientes.
self addMorph: botonContratos.
self addMorph: botonViajes.
self addMorph: botonInfoClientes.
self addMorph: botonInfoViajes.



]
