"
Clase ViajeOrganizado. Subclase de Viaje.
        			   Viaje 
         			      ^
		    ViajeOrganizado

    Instance Variables
	cantDiasDuracion:		<Object>
	colFechasSalida:		<Object>
	cupo:		<Object>
	planViaje:		<Object>
	tuplasExcursionesOpValores:		<Object>



"
Class {
	#name : #ViajeOrganizado,
	#superclass : #Viaje,
	#instVars : [
		'colFechasSalidaCupos',
		'cantDiasDuracion',
		'colExcurisionesOpcionales',
		'colEtapas'
	],
	#category : #POOTpObligatorio
}

{ #category : #constructor }
ViajeOrganizado class >> crearConNombre: unNombre yCostoPorPersona: unCosto yImpuesto: unImpuesto yValorPlus: unValor  yCantDiasDuracion: unaCantidad yEtapas: colEtapas yFechasSalidaCupos: colFeSalidaCupos [
	|unViajeOrganizado|
	unViajeOrganizado := self new.
	unViajeOrganizado iniConNombre: unNombre yCostoPorPersona: unCosto yImpuesto: unImpuesto yValorPlus: unValor  yCantDiasDuracion: unaCantidad yEtapas: colEtapas yFechasSalidaCupos: colFeSalidaCupos.
	^unViajeOrganizado  
]

{ #category : #constructor }
ViajeOrganizado class >> crearConNombre: unNombre yCostoPorPersona: unCosto yImpuesto: unImpuesto yValorPlus: unValor  yCantDiasDuracion: unaCantidad yEtapas: colEtapas yFechasSalidaCupos: colFeSalidaCupos yExcursionesOpcionales: colExcursiones [
	|unViajeOrganizado|
	unViajeOrganizado := self new.
	unViajeOrganizado iniConNombre: unNombre yCostoPorPersona: unCosto yImpuesto: unImpuesto yValorPlus: unValor  yCantDiasDuracion: unaCantidad yEtapas: colEtapas yFechasSalidaCupos: colFeSalidaCupos yExcursionesOpValores: colExcursiones .
	^unViajeOrganizado  
]

{ #category : #propios }
ViajeOrganizado >> agregarEtapa: unaEtapa [

colEtapas add: unaEtapa 
]

{ #category : #aplicacion }
ViajeOrganizado >> agregarExcurcionOpcionalConNombre: nomExcursion yCosto: unCosto [
  |tupla|
  tupla := ExcursionOpcional crearConNombre: nomExcursion yValor: unCosto.
  colExcurisionesOpcionales add: tupla.
	^true

]

{ #category : #aplicacion }
ViajeOrganizado >> agregarFechaSalida: unaFecha yCupo: unCupo [
  |tupla|
  tupla := FechaSalidaCupo crearConFechaSalida: unaFecha yCupo: unCupo.
  colFechasSalidaCupos add: tupla.
	^true 

]

{ #category : #aplicacion }
ViajeOrganizado >> buscarExcursionConNombre: nomExcursion [
	^colExcurisionesOpcionales detect: [:cadaExcursion | cadaExcursion verificarExcursionConNombre: nomExcursion] ifNone: [nil].

]

{ #category : #propios }
ViajeOrganizado >> buscarSalida: unaF [

	| salida |
	salida := colFechasSalidaCupos
		          detect: [ :elem | elem verificarFechaSalida: unaF ]
		          ifNone: [ nil ].
	^ salida
]

{ #category : #aplicacion }
ViajeOrganizado >> cambiarFechaConFechaACambiar: feCambio fechaNueva: unaFecha [

	| tupla |
	tupla := self buscarSalida: feCambio.
	tupla ifNotNil: [ 
		tupla cambiarFecha: unaFecha.
		^ true ].
	^ false
]

{ #category : #aplicacion }
ViajeOrganizado >> desocuparCuposConCantidad:unaCantPers yFecha: unaFecha [
  |tupla|
  tupla := colFechasSalidaCupos detect:[:t | t verificarFechaSalida: unaFecha] ifNone:[^nil].
  (tupla) ifNotNil: [
		tupla desocupar: unaCantPers. 
	]
]

{ #category : #propios }
ViajeOrganizado >> esViajeOrganizado [
^ true.
]

{ #category : #visualizadores }
ViajeOrganizado >> getCantDiasDuracion [
^cantDiasDuracion 
]

{ #category : #visualizadores }
ViajeOrganizado >> getColFechasSalidaCupos [ 
^colFechasSalidaCupos 
]

{ #category : #inicializadores }
ViajeOrganizado >> iniConNombre: unNombre yCostoPorPersona: unCosto yImpuesto: unImpuesto yValorPlus: unValor  yCantDiasDuracion: unaCantidad yEtapas: unaColEtapas yFechasSalidaCupos: colFeSalidaCupos [
	self inicializarConNombre: unNombre yCostoPorPersona: unCosto yImpuesto: unImpuesto yValorPlus: unValor.
	cantDiasDuracion := unaCantidad.
	colEtapas := unaColEtapas. 
	colFechasSalidaCupos := colFeSalidaCupos.
	colExcurisionesOpcionales := OrderedCollection new.
]

{ #category : #inicializadores }
ViajeOrganizado >> iniConNombre: unNombre yCostoPorPersona: unCosto yImpuesto: unImpuesto yValorPlus: unValor  yCantDiasDuracion: unaCantidad yEtapas: unaColEtapas yFechasSalidaCupos: colFeSalidaCupos yExcursionesOpValores: colExcursiones [
	self inicializarConNombre: unNombre yCostoPorPersona: unCosto yImpuesto: unImpuesto yValorPlus: unValor.
	cantDiasDuracion := unaCantidad.
	colEtapas := unaColEtapas. 
	colFechasSalidaCupos := colFeSalidaCupos.
	colExcurisionesOpcionales := colExcursiones.
]

{ #category : #visualizadores }
ViajeOrganizado >> obtenerDiasViaje [
^ cantDiasDuracion.
]

{ #category : #visualizadores }
ViajeOrganizado >> obtenerEtapas [

	^ colEtapas 
]

{ #category : #visualizadores }
ViajeOrganizado >> obtenerExcursiones [
^colExcurisionesOpcionales  
]

{ #category : #visualizadores }
ViajeOrganizado >> obtenerSalidas [

	| s |
	colFechasSalidaCupos ifNotNil: [
		s := colFechasSalidaCupos collect: [ :elem | elem toString ] ].
	^ s
]

{ #category : #aplicacion }
ViajeOrganizado >> obtenerValorDeUnaExcursion: nomExcursion [
	|unaTupla unValor|
	unaTupla:= self buscarExcursionConNombre: nomExcursion.
	(unaTupla)ifNotNil: [unValor:= unaTupla getValor.].
	^unValor
	
]

{ #category : #aplicacion }
ViajeOrganizado >> ocuparCuposConCantidad:cantP yFecha: unaFecha [
  |tupla|
  tupla := colFechasSalidaCupos detect:[:t | t verificarFechaSalida: unaFecha] ifNone:[^nil].
  (tupla) ifNotNil: [
		(tupla ocupar: cantP). 
	]

]

{ #category : #aplicacion }
ViajeOrganizado >> verificarCupoConCantidadPersonas: cantP yFecha: unaFecha [

	| ret tupla |
	ret := false.
	tupla := colFechasSalidaCupos
		         detect: [ :cadaTupla | 
		         cadaTupla verificarFechaSalida: unaFecha ]
		         ifNone: [ ^ false ].
	tupla ifNotNil: [ ret := tupla hayCupoParaCantidadPersonas: cantP ].
	^ ret
]

{ #category : #aplicacion }
ViajeOrganizado >> verificarEntreFechasConFecha1: unaFecha yFecha2: otraFecha [
"Método que recibe dos fechas como límites de un rango y devuelve sí existe una fecha en el rango"
	|rta|
	rta:= colFechasSalidaCupos anySatisfy: [ :t | 
			"Con el mensaje X between: A and:B obtengo un booleano sí X se encuentra entre A y B"
			(t getFechaSalida) between: unaFecha and: otraFecha ].
	^rta
]

{ #category : #aplicacion }
ViajeOrganizado >> verificarViajeOrganizado [
^true

]

{ #category : #aplicacion }
ViajeOrganizado >> verificarViajeRealizado [ 
  |ret|
  ret := colFechasSalidaCupos anySatisfy: [:tupla | ((tupla verificarFechaPasada) = false)].
  ^ret


]
