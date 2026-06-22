"
Clase Contrato de trabajo Obligatorio.
    Instance Variables
	cantPersonas:		<Object>
	colCuotas:		<Object>
	estado:		<Object>
	fechaContrato:		<Object>
	fechaViajeSeleccionada:		<Object>
	numeroContrato:		<Object>
	valorTotal:		<Object>
	viajeContratado:		<Object>


    Implementation Points
"
Class {
	#name : #Contrato,
	#superclass : #Object,
	#instVars : [
		'numeroContrato',
		'fechaContrato',
		'viajeContratado',
		'fechaViajeSeleccionada',
		'cantPersonas',
		'colCuotasSinPagar',
		'colCuotasPagadas',
		'valorTotal',
		'colExcursionesContratadas',
		'estado',
		'esFlexible',
		'reembolso'
	],
	#classInstVars : [
		'contador'
	],
	#category : #POOTpObligatorio
}

{ #category : #constructor }
Contrato class >> crearConUnViaje: unViaje yFechaSeleccionada: unaFecha yCantPersonas: unaCantPers yCantCuotas: cantCuotas yValorTotlal: unCosto yEsFlexible: flexible [
	|unContrato unaColCuotas|
	unContrato := self new.
	unViaje ocuparCuposConCantidad: unaCantPers yFecha:unaFecha. 
	unaColCuotas := self generarCuotasConCantidad: cantCuotas yCosto: unCosto.   
	unContrato inicializarConUnViaje: unViaje yFechaSeleccionada: unaFecha yCantPersonas: unaCantPers 	yColCuotas: unaColCuotas yValorTotlal: unCosto yEsFlexible: flexible.
	^unContrato 
]

{ #category : #aplicacion }
Contrato class >> generarCuotasConCantidad: cantCuot yCosto: unCosto [
	|iter fechaCuota unaCuota colCuotas unValor|
	colCuotas := OrderedCollection new.
	(cantCuot > 0) ifTrue: [
	iter := 1.
	fechaCuota := (Date today) addMonths: 1.  
	unValor := (unCosto / cantCuot). 
	[iter <= cantCuot] whileTrue: [ 
		unaCuota := Cuota crearConValor: unValor yFechaVencimiento: fechaCuota.  
		colCuotas add: unaCuota. 
		iter := iter + 1.
   		fechaCuota := fechaCuota addMonths:1.
	 ].
		 ]. 
^colCuotas. 
	
]

{ #category : #aplicacion }
Contrato class >> generarNumero [
    | nro |
    nro := contador .
    contador := contador + 1.
    ^ nro
]

{ #category : #initialization }
Contrato class >> initialize [
    contador := 1.
]

{ #category : #aplicacion }
Contrato >> actualizarFechaSeleccionada: fechaNueva [
fechaViajeSeleccionada := fechaNueva. 
]

{ #category : #aplicacion }
Contrato >> actualizarValorConUnCosto: unCosto [
	|cantCuotasSinPagar|
	cantCuotasSinPagar := self obtenerCantCuotasSinPagar.
	colCuotasSinPagar do: [:cadaCuota | cadaCuota aumentarValor: (unCosto/cantCuotasSinPagar)].
	^true
]

{ #category : #aplicacion }
Contrato >> agregarExcursionAContratoConNomExcursion: nomExcursion yCantPersonas: cantP [
  |unaExcursion|
	unaExcursion := viajeContratado buscarExcursionConNombre: nomExcursion.   
	unaExcursion ifNil: [Transcript show: 'ERROR: Excursion no encontrada.'; cr.] ifNotNil: [
		(self verificarPosibilidadDeAgregarExcursionConCantPersonas: cantP) ifTrue: [^(self contratarExcursionCon: unaExcursion yCantPersonas: cantP)]   
		 ].
	^false
]

{ #category : #aplicacion }
Contrato >> cancelar: unCliente [
 |ret|
	ret := false.
  (self verificarContratoRealizado) ifFalse: [ 
	estado := 'cancelado'.
	ret := self realizarReembolso: unCliente. 
	 ].	
  ^ret

]

{ #category : #aplicacion }
Contrato >> contratarExcursionCon: unaExcursion yCantPersonas: cantP [

	| unaExcursionContratada unCosto |
	unaExcursionContratada := ExcursionContratada
		                          crearConExcursionOpcional: unaExcursion
		                          yCantidadPersonas: cantP.
	colExcursionesContratadas add: unaExcursionContratada. 	
	unCosto := unaExcursionContratada obtenerCostoDeExcursionContratada.
	^ self actualizarValorConUnCosto: unCosto
]

{ #category : #aplicacion }
Contrato >> efectivizar [
  |exito|
  exito := false.
  self verificarCuotasPagadas ifTrue: [ estado := 'efectivizado'. exito := true].
	^exito 

]

{ #category : #visualizadores }
Contrato >> getCantidadPersonas [
  ^cantPersonas  

]

{ #category : #visualizadores }
Contrato >> getColCuotasPagadas [
^colCuotasPagadas   
]

{ #category : #visualizadores }
Contrato >> getColCuotasSinPagar [
^colCuotasSinPagar  
]

{ #category : #visualizadores }
Contrato >> getEsFlexible [
^esFlexible 
]

{ #category : #visualizadores }
Contrato >> getEstado [
 ^estado
]

{ #category : #visualizadores }
Contrato >> getExcursionesContratadas [
^colExcursionesContratadas  
]

{ #category : #visualizadores }
Contrato >> getFechaContrato [
^fechaContrato 
]

{ #category : #visualizadores }
Contrato >> getFechaViajeSeleccionada [ 
^fechaViajeSeleccionada 
]

{ #category : #visualizadores }
Contrato >> getNumeroContrato [
  ^numeroContrato 

]

{ #category : #visualizadores }
Contrato >> getReembolso [
^reembolso  
]

{ #category : #visualizadores }
Contrato >> getValorTotal [
  ^valorTotal 

]

{ #category : #visualizadores }
Contrato >> getViajeContratado [ 
	^viajeContratado 
]

{ #category : #inicializadores }
Contrato >> inicializarConUnViaje: unViaje yFechaSeleccionada: unaFecha yCantPersonas: unaCantPers yColCuotas: unaCol yValorTotlal: unCosto yEsFlexible: flexible [
	
	fechaContrato := Date today. 
	numeroContrato := self class generarNumero.
	viajeContratado  := unViaje.
	fechaViajeSeleccionada := unaFecha.
	cantPersonas := unaCantPers.
	colCuotasSinPagar := unaCol.
	colCuotasPagadas := OrderedCollection new.
	valorTotal:=unCosto.
	estado := 'pendiente'.
	colExcursionesContratadas  := OrderedCollection new.
	esFlexible := flexible. 
	reembolso := 0.

]

{ #category : #aplicacion }
Contrato >> obtenerCantCuotasSinPagar [
	^colCuotasSinPagar size 
]

{ #category : #aplicacion }
Contrato >> obtenerValorDeReembolso [

	| mesesRestantes |
	mesesRestantes := (fechaViajeSeleccionada - Date today) days / 30.
	mesesRestantes > 3 ifTrue: [ ^valorTotal * 0.75 ].
	mesesRestantes >= 2 ifTrue: [ ^valorTotal * 0.5 ].
	^valorTotal * 0.25
]

{ #category : #aplicacion }
Contrato >> obtenerValorViaje [
^ (viajeContratado calcularCostoConCantPersonas: cantPersonas). 

]

{ #category : #aplicacion }
Contrato >> pagarCuotas: cantCuotasAPagar [ 
	|exito cantCuotasPagadas|
	exito := self verificarCuotas: cantCuotasAPagar.
	exito ifTrue: [ 
		cantCuotasPagadas := 0.
		[cantCuotasPagadas < cantCuotasAPagar] whileTrue: [ 
			colCuotasPagadas add: (colCuotasSinPagar at: 1). 
			colCuotasSinPagar remove: (colCuotasSinPagar at: 1).
			cantCuotasPagadas := cantCuotasPagadas + 1.  
			 ]		
   ].
^exito
]

{ #category : #aplicacion }
Contrato >> realizarReembolso: unCliente [
reembolso := self obtenerValorDeReembolso. 
  ^unCliente reembolsar: reembolso 
 
]

{ #category : #aplicacion }
Contrato >> realizarReprogramacion: unViaje fecha: nuevaFecha [
  (viajeContratado = unViaje) ifTrue: [(self verificarCambioDeFecha) ifTrue: [ 
		viajeContratado desocuparCupos: cantPersonas fechaSeleccionada: fechaViajeSeleccionada.  
		unViaje ocuparCuposConCantidad: cantPersonas yFechaSeleccionada: nuevaFecha. 
		fechaViajeSeleccionada := nuevaFecha. 
		]
	 ] ifFalse: [
	viajeContratado desocuparCupos: cantPersonas fechaSeleccionada: fechaViajeSeleccionada.  
	unViaje ocuparCuposConCantidad: cantPersonas yFechaSeleccionada: nuevaFecha.  
	viajeContratado := unViaje
	].   

]

{ #category : #aplicacion }
Contrato >> reprogramarFecha: nuevaFecha [
	|exito|
	exito := false.
	(self verificarReprogramacionDeFechaConCantP: cantPersonas yFecha: nuevaFecha) ifTrue: [   
  viajeContratado desocuparCuposConCantidad: cantPersonas yFecha: fechaViajeSeleccionada.
  viajeContratado ocuparCuposConCantidad: cantPersonas yFecha: nuevaFecha.  
  fechaViajeSeleccionada := nuevaFecha.
	exito := true. 
	].
^exito 
]

{ #category : #aplicacion }
Contrato >> verificarCambioDeFecha [

	| ret |
	ret := false.
	viajeContratado verificarViajeOrganizado ifTrue: [ 
		esFlexible ifTrue: [ ret := true ] ].
	^ ret
]

{ #category : #aplicacion }
Contrato >> verificarConNumero:unNro [
^(numeroContrato =unNro) .

]

{ #category : #aplicacion }
Contrato >> verificarContratoAVencer [
	|ret|
	ret := false.
 	(self verificarCuotasPagadas) ifFalse:[  
		ret := ((Date today) >= (fechaViajeSeleccionada - 30 days)).
	]. 
	^ret

]

{ #category : #aplicacion }
Contrato >> verificarContratoRealizado [
^Date today > fechaViajeSeleccionada  
]

{ #category : #aplicacion }
Contrato >> verificarCuotas: cantCuotasAPagar [
    ^ cantCuotasAPagar > 0 and: [ cantCuotasAPagar <= colCuotasSinPagar size ]
]

{ #category : #aplicacion }
Contrato >> verificarCuotasPagadas [
^colCuotasSinPagar isEmpty
]

{ #category : #aplicacion }
Contrato >> verificarFaltaMasDeUnaSemana [
^(((fechaViajeSeleccionada - Date today)days)>7)
]

{ #category : #aplicacion }
Contrato >> verificarFechaSeleccionadaConUnaFecha: unaFecha [
^fechaViajeSeleccionada =unaFecha 
]

{ #category : #aplicacion }
Contrato >> verificarPosibilidadDeAgregarExcursionConCantPersonas: cantP [
	|rta|
	rta := false.
	(self verificarFaltaMasDeUnaSemana) ifTrue: [ rta := cantPersonas >= cantP].
	^rta
	
]

{ #category : #aplicacion }
Contrato >> verificarReprogramacionDeFechaConCantP: cantP yFecha: nuevaFecha [
 |ret|
  ret := false.
(fechaViajeSeleccionada ~= nuevaFecha) ifTrue: [ 	
  (self verificarCambioDeFecha) ifTrue: [ 
	(viajeContratado  verificarDisponibilidadViajeConCantPersonas: cantP yFecha: nuevaFecha) ifTrue: [ 		
			ret := true.
			]
   ] 
]. 
  ^ret

]

{ #category : #aplicacion }
Contrato >> verificarViajeOrgEnAño: año [
  |ret|
  ret := false. 
  (estado = 'efectivizado') ifTrue: [ (viajeContratado verificarViajeOrganizado) ifTrue: [ 
		(fechaViajeSeleccionada year = año) ifTrue: [ 
			ret := true.
			 ]
		]   
	]. 
^ret

]

{ #category : #aplicacion }
Contrato >> verificarViajeRealizado [
  ^Date today > fechaViajeSeleccionada 

]
