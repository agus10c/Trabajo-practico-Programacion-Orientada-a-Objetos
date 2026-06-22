Class {
	#name : #VentanaViajes,
	#superclass : #SystemWindow,
	#instVars : [
		'empresa',
		'campoNombre',
		'campoCosto',
		'campoImpuesto',
		'campoValorPlus',
		'campoCiudad',
		'campoDisponibilidad',
		'formularioViajeEspecial',
		'formularioViajeOrganizado'
	],
	#category : #POOTpObligatorio
}

{ #category : #constructor }
VentanaViajes class >> crearConEmpresa: unaEmpresa [
    |unaVentana|
    unaVentana :=  self new.
	 unaVentana iniConEmpresa: unaEmpresa.
	^unaVentana 	
]

{ #category : #aplicacion }
VentanaViajes >> abrir [
 self openInWorld.
]

{ #category : #aplicacion }
VentanaViajes >> abrirFormularioViajeEspecial [
	formularioViajeEspecial openInWorld. 
]

{ #category : #aplicacion }
VentanaViajes >> abrirFormularioViajeOrganizado [
	formularioViajeOrganizado openInWorld. 
]

{ #category : #aplicacion }
VentanaViajes >> agregarExcursion [

	| nombre nomExc costo exito |
	nombre := UIManager default request: 'Ingrese el nombre del viaje'.
	nombre ifNil: [ ^ nil ].

	nomExc := UIManager default request: 'Ingrese nombre de la excursión'.
	nomExc ifNil: [ ^ nil ].

	costo := UIManager default request: 'Ingrese costo de la excursión'.
	costo ifNil: [ ^ nil ].

	exito := empresa
		         agregarExcursionOpcionalAViajeConNombreDeViaje: nombre
		         yNomExcursion: nomExc
		         yCosto: costo asNumber.
	exito
		ifTrue: [ 
		UIManager default inform: 'Excursión agregada correctamente.' ]
		ifFalse: [ 
		UIManager default alert: 'No se pudo agregar la excursion.' ]
]

{ #category : #aplicacion }
VentanaViajes >> agregarFechaSalida [

	| nombre fecha cupo exito |
	nombre := UIManager default request: 'Ingrese el nombre del viaje'.
	nombre ifNil: [ ^ nil].

	fecha := UIManager default request:
		         'Ingrese fecha de salida (mm/dd/yyyy)'.
	fecha ifNil: [ ^ nil ].

	cupo := UIManager default request: 'Ingrese cupos'.
	cupo ifNil: [ ^ nil ].

	exito := empresa
		         agregarFechaSalidaAViajeOrganizadoCon: nombre
		         yUnaFecha: (Date readFrom: fecha readStream)
		         yUnCupo: cupo asNumber.
	exito
		ifTrue: [ UIManager default inform: 'Fecha agregada correctamente.' ]
		ifFalse: [ UIManager default alert: 'No se pudo agregar la fecha.' ]
]

{ #category : #aplicacion }
VentanaViajes >> altaViajeEspecial [

	| nombre costo impuesto valorPlus ciudad disponibilidad fechaSalida fechaRegreso exito |
	nombre := campoNombre contents asString trimBoth.
	costo := campoCosto contents asString trimBoth.
	impuesto := campoImpuesto contents asString trimBoth.
	valorPlus := campoValorPlus contents asString trimBoth.
	ciudad := campoCiudad contents asString trimBoth.
	disponibilidad := campoDisponibilidad contents asString trimBoth.

	(nombre isEmpty or: [ 
		 costo isEmpty or: [ 
			 impuesto isEmpty or: [ 
				 valorPlus isEmpty or: [ 
					 ciudad isEmpty or: [ disponibilidad isEmpty ] ] ] ] ]) ifTrue: [ 
		UIManager default alert: 'Hay campos sin completar'.
		^ nil ].

	fechaSalida := UIManager default request:
		               'Ingrese fecha salida (mm/dd/yyyy)'.
	fechaSalida ifNotNil: [ 
		fechaRegreso := UIManager default request:
			                'Ingrese fecha regreso (mm/dd/yyyy)'.
		fechaRegreso ifNotNil: [ 
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
				UIManager default inform: 'Viaje dado de alta correctamente.' ]
				ifFalse: [ 
				UIManager default alert: 'No se pudo dar de alta el viaje.' ] ] ]
]

{ #category : #aplicacion }
VentanaViajes >> bajaViaje [
    | nombre exito |
    nombre := UIManager default request: 'Ingrese el nombre del viaje a dar de baja'.
    nombre ifNotNil: [ 
		exito := empresa realizarBajaViajeConNombre: nombre.
			nombre := nombre asString.
   			exito ifTrue: [ UIManager default inform: 'Viaje dado de baja correctamente.' ] 
			ifFalse: [ UIManager default alert: 'No se pudo dar de baja el viaje.' ].
	 ].


    
]

{ #category : #aplicacion }
VentanaViajes >> cambiarFecha [

	| nombre fecha fechaNueva exito |
	nombre := UIManager default request: 'Ingrese nombre del viaje'.
	nombre ifNil: [ ^ nil ].

	fecha := UIManager default request:
		         'Ingrese la fecha a cambiar en formato (mm/dd/yyyy)'.
	fecha ifNil: [ ^ nil].

	fechaNueva := UIManager default request:
		              'Ingrese la fecha nueva en formato (mm/dd/yyyy)'.
	fechaNueva ifNil: [ ^ nil ].

	exito := empresa
		         cambiarFechaViaje: nombre
		         ConFechaACambiar: (Date readFrom: fecha readStream)
		         fechaNueva: (Date readFrom: fechaNueva readStream).
	exito
		ifTrue: [ 
			UIManager default inform:
				'Cambio de fecha realizado correctamente.' ]
		ifFalse: [ 
			UIManager default alert:
				'ERROR - No se pudo realizar el cambio de fecha.' ]
]

{ #category : #aplicacion }
VentanaViajes >> entreFechas [

	| fecha1 fecha2 ventana texto colViajes scroll morphTexto botonCerrar |
	fecha1 := UIManager default request: 'Ingrese una fecha (mm/dd/yyyy)'.
	fecha1 ifNil: [ ^ nil ].
	fecha2 := UIManager default request:
		          'Ingrese otra fecha (mm/dd/yyyy)'.
	fecha2 ifNil: [ ^ nil ].
	colViajes := empresa
		             obtenerViajesEntreFecha1:
		             (Date readFrom: fecha1 readStream)
		             yFecha2: (Date readFrom: fecha2 readStream).

	ventana := BorderedMorph new.
	ventana extent: 600 @ 420.
	ventana color: Color veryLightGray.
	ventana borderWidth: 2.

	texto := String streamContents: [ :s | 
		         s
			         nextPutAll: 'Viajes entre ';
			         nextPutAll: fecha1 asString;
			         nextPutAll: ' y ';
			         nextPutAll: fecha2 asString;
			         cr.
		         s
			         nextPutAll: '-----------------------------';
			         cr.
		         colViajes do: [ :v | 
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
VentanaViajes >> iniConEmpresa: unaEmpresa [
	empresa := unaEmpresa. 
	formularioViajeEspecial := FormularioViajeEspecial crearConEmpresa: empresa. 
	formularioViajeOrganizado := FormularioViajeOrganizado crearConEmpresa: empresa. 
]

{ #category : #inicializadores }
VentanaViajes >> initialize [

	| origen botonAltaViajeEspecial botonAltaViajeOrganizado botonBajaViaje botonAgregarExcursion botonAgregarFechaSalida botonCambiarFecha botonEntreFechas |
	super initialize.

	self setLabel: 'Gestión de Viajes'.
	self color: Color veryLightGray.
	self bounds: (80 @ 80 extent: 250 @ 300).

	origen := self innerBounds origin.

	"Boton Alta Viaje Especial"
	botonAltaViajeEspecial := Boton new.
	botonAltaViajeEspecial label: 'Alta Viaje Especial'.
	botonAltaViajeEspecial position: origen + (20 @ 30).
	botonAltaViajeEspecial mouseAction: [ 
		self abrirFormularioViajeEspecial ].
	self addMorph: botonAltaViajeEspecial.

	"Boton Alta Viaje Organizado"
	botonAltaViajeOrganizado := Boton new.
	botonAltaViajeOrganizado label: 'Alta Viaje Organizado'.
	botonAltaViajeOrganizado position: origen + (20 @ 70).
	botonAltaViajeOrganizado mouseAction: [ 
		self abrirFormularioViajeOrganizado ].
	self addMorph: botonAltaViajeOrganizado.

	"Boton Baja Viaje"
	botonBajaViaje := Boton new.
	botonBajaViaje label: 'Baja Viaje'.
	botonBajaViaje position: origen + (20 @ 110).
	botonBajaViaje mouseAction: [ self realizarBaja ].
	self addMorph: botonBajaViaje.

	"Boton Agregar Excursion"
	botonAgregarExcursion := Boton new.
	botonAgregarExcursion label: 'Agregar Excursion'.
	botonAgregarExcursion position: origen + (20 @ 150).
	botonAgregarExcursion mouseAction: [ self agregarExcursion ].
	self addMorph: botonAgregarExcursion.

	"Boton Agregar Fecha Salida"
	botonAgregarFechaSalida := Boton new.
	botonAgregarFechaSalida label: 'Agregar Fecha Salida'.
	botonAgregarFechaSalida position: origen + (20 @ 190).
	botonAgregarFechaSalida mouseAction: [ self agregarFechaSalida ].
	self addMorph: botonAgregarFechaSalida.

	"Boton Cambiar Fecha"
	botonCambiarFecha := Boton new.
	botonCambiarFecha label: 'Cambiar Fecha'.
	botonCambiarFecha position: origen + (20 @ 230).
	botonCambiarFecha mouseAction: [ self cambiarFecha ].
	self addMorph: botonCambiarFecha.

	"Boton Viajes entre fechas"
	botonEntreFechas := Boton new.
	botonEntreFechas label: 'Viajes entre fechas'.
	botonEntreFechas position: origen + (20 @ 270).
	botonEntreFechas mouseAction: [ self entreFechas ].
	self addMorph: botonEntreFechas
]

{ #category : #aplicacion }
VentanaViajes >> realizarBaja [
    | nombre exito |
    nombre := UIManager default request: 'Ingrese el nombre del viaje a dar de baja'.
    nombre ifNotNil: [ 
		exito := empresa realizarBajaViajeConNombre: nombre.
			nombre := nombre asString.
   			exito ifTrue: [ UIManager default inform: 'Viaje dado de baja correctamente.' ] 
			ifFalse: [ UIManager default alert: 'No se pudo dar de baja el viaje.' ].
	 ].


    
]
