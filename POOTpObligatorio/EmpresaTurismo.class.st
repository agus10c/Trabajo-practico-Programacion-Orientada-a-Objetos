Class {
	#name : #EmpresaTurismo,
	#superclass : #Object,
	#instVars : [
		'colClientes',
		'colViajes'
	],
	#category : #POOTpObligatorio
}

{ #category : #constructor }
EmpresaTurismo class >> crearConColClientes: cClientes yColViajes: cViajes [
	|unaEmpresaTurismo|
	unaEmpresaTurismo := self new.
	unaEmpresaTurismo iniConColClientes: cClientes yColViajes: cViajes.
   ^unaEmpresaTurismo 
		
]

{ #category : #constructor }
EmpresaTurismo class >> crearNuevaEmpresa [
	|unaEmpresaTurismo|
	unaEmpresaTurismo := self new.
	unaEmpresaTurismo iniEmpresaTurismo.
	^unaEmpresaTurismo

]

{ #category : #aplicacion }
EmpresaTurismo >> agregarCliente: unCliente [
	|exito|
	exito := false.
	(self verificarClienteExistente: (unCliente getDni)) ifFalse:[colClientes add: unCliente. exito := true].
	^exito 
]

{ #category : #aplicacion }
EmpresaTurismo >> agregarExcursionOpcionalAContratoConNomExcursion: nomExcursion yCantPersonas: cantP yContrato: unContrato [ 
	^unContrato agregarExcursionAContratoConNomExcursion: nomExcursion yCantPersonas: cantP

]

{ #category : #aplicacion }
EmpresaTurismo >> agregarExcursionOpcionalAContratoConNomExcursion: nomExcursion yCantPersonas: cantP yNroContrato: nroContrato [ 
	|unContrato ret|
	ret := false.
	unContrato := self buscarContratoConNumero: nroContrato. 
	unContrato ifNil: [  Transcript show: 'ERROR: Contrato no encontrado.'; cr. ] ifNotNil: [
		ret := unContrato agregarExcursionAContratoConNomExcursion: nomExcursion yCantPersonas: cantP.
		].  
	^ret

]

{ #category : #aplicacion }
EmpresaTurismo >> agregarExcursionOpcionalAViajeConNombreDeViaje: nomViaje yNomExcursion: unNombre yCosto: unCosto [

	| unViaje ret |
	ret := false.
	unViaje := self buscarViaje: nomViaje.
	unViaje
		ifNil: [ 
			Transcript
				show: 'ERROR: Viaje no encontrado.';
				cr ]
		ifNotNil: [ 
			ret := unViaje
				       agregarExcurcionOpcionalConNombre: unNombre 
				       yCosto: unCosto ].
	^ ret
]

{ #category : #aplicacion }
EmpresaTurismo >> agregarExcursionesOpcionalesAContratoConTuplasNomExcursionCantP: tuplasNomExcursionCantP yNroContrato: nroContrato [
 |unContrato ret|
	ret := true.
	unContrato := self buscarContratoConNumero: nroContrato.
	unContrato ifNil: [ Transcript show: 'ERROR: Contrato no encontrado.'; cr.] ifNotNil: [ 
		ret whileTrue: [  
	tuplasNomExcursionCantP do: [:tupla |ret := self agregarExcursionOpcionalAContratoConNomExcursion: (tupla at:1) yCantPersonas: (tupla at:2) yContrato: unContrato]. 
		]
	].
^ret
]

{ #category : #aplicacion }
EmpresaTurismo >> agregarFechaSalidaAViajeOrganizadoCon: nomViaje yUnaFecha: unaFecha yUnCupo: unCupo [
	 |unViaje ret|
	ret := false.
	unViaje := self buscarViaje: nomViaje.
	unViaje ifNil: [Transcript show: 'ERROR: Viaje no encontrado.'; cr.] ifNotNil: [ret := unViaje agregarFechaSalida: unaFecha yCupo: unCupo].
	^ret 
]

{ #category : #aplicacion }
EmpresaTurismo >> alctualizarFechaContratosConFecha: unaFecha yFechaNueva: fechaNueva [ 
	colClientes do: [ :cadaCliente | cadaCliente alctualizarFechaContratosEnClienteConFecha: unaFecha yFechaNueva: fechaNueva ]
]

{ #category : #aplicacion }
EmpresaTurismo >> buscarClienteConContrato: nroContrato [
	^colClientes detect: [:cadaCliente | cadaCliente verificarContratoEnCliente: nroContrato ] ifNone: [nil].
]

{ #category : #aplicacion }
EmpresaTurismo >> buscarClienteConDNI: unDni [
^ colClientes detect: [:c | c verificarConDNI: unDni  ] ifNone: [ nil ].
]

{ #category : #aplicacion }
EmpresaTurismo >> buscarContratoConNumero: nroContrato [
	|unContrato|
	unContrato := nil.
	colClientes do:[:cliente | unContrato := cliente buscarContratoEnCliente: nroContrato. unContrato ifNotNil: [^unContrato].]. 
	^unContrato 
	
]

{ #category : #aplicacion }
EmpresaTurismo >> buscarViaje: nomViaje [
 ^ colViajes detect: [:v | v verificarViaje: nomViaje ] ifNone: [ nil ].
]

{ #category : #aplicacion }
EmpresaTurismo >> cambiarFechaViaje: nomViaje ConFechaACambiar: unaFecha fechaNueva: fechaNueva [

	| unViaje exito |
	exito := false.
	unViaje := self buscarViaje: nomViaje.
	unViaje
		ifNil: [ 
			Transcript
				show: 'ERROR: Viaje no encontrado.';
				cr ]
		ifNotNil: [ 
			exito := unViaje
				         cambiarFechaConFechaACambiar: unaFecha
				         fechaNueva: fechaNueva.
			exito ifTrue: [ 
				self
					alctualizarFechaContratosConFecha: unaFecha
					yFechaNueva: fechaNueva ] ].
	^ exito
]

{ #category : #aplicacion }
EmpresaTurismo >> cancelarContrato: nroContrato [
	|unCliente ret|
	ret := false.
	unCliente :=self buscarClienteConContrato: nroContrato. 
	unCliente ifNil: [ Transcript show: 'ERROR: Cliente con contrato no encontrado.'; cr.] ifNotNil: [ 
		ret := unCliente realizarCancelacion: nroContrato. 
		 ].
	^ret
]

{ #category : #aplicacion }
EmpresaTurismo >> efectivizarContrato: nroContrato [	
	|unCliente ret|
	ret := false.
	unCliente := self buscarClienteConContrato: nroContrato. 
	unCliente ifNil: [ Transcript show: 'ERROR: Cliente con contrato no encontrado.'; cr.]ifNotNil: [   
		ret := unCliente realizarEfectivizacion: nroContrato. 
		ret ifTrue: [self hacerViajeroFrecuente: unCliente].
		 ].
	^ret
	 
]

{ #category : #aplicacion }
EmpresaTurismo >> generarNuevoContratoConDni: dni yNombreViaje: nv yFechaSeleccionada: fs yCantidadPersonas: cp yCantCuotas: cc yPagarConMillas: pm yEsFlexible: f [

 | unViaje unCliente okViaje okCuotas|
	(cp>0) ifTrue: [   
    unViaje := self buscarViaje: nv.
	 (unViaje) ifNotNil:[
		okViaje := unViaje verificarDisponibilidadViajeConCantPersonas: cp yFecha: fs. 	
			(okViaje) ifTrue: [
				okCuotas := self verificarCantidadCuotas: cc fechaViaje: fs.
				(okCuotas) ifTrue: [  
					unCliente := self buscarClienteConDNI: dni.
					(unCliente) ifNil: [  
						Transcript show: 'ERROR: Cliente no encontrado.'; cr. 
						] ifNotNil: [unCliente generarContratoConViaje: unViaje yFechaSeleccionada: fs         								yCantidadPersonas: cp yCantCuotas: cc yPagarConMillas: pm yEsFlexible: f.]
				]ifFalse: [ Transcript show: 'ERROR: Cantidad de cuotas inválida.'; cr.]
			]ifFalse: [ Transcript show: 'ERROR: No hay cupos disponibles.'; cr.  ].
		]ifNil: [ Transcript show: 'ERROR: Viaje no encontrado.'; cr.].
   ] ifFalse: [ Transcript show: 'Ingreso mal la cantidad de personas.'; cr.] 


    
]

{ #category : #visualizadores }
EmpresaTurismo >> getColClientes [ 
	^colClientes 
]

{ #category : #visualizadores }
EmpresaTurismo >> getColContratos [ 
	|colContratos|
	colContratos := OrderedCollection new.
	colClientes do: [:cliente | colContratos addAll: cliente getColContratos].
	^colContratos 
]

{ #category : #visualizadores }
EmpresaTurismo >> getColViajes [ 
	^colViajes 
]

{ #category : #aplicacion }
EmpresaTurismo >> hacerViajeroFrecuente: unCliente [ 	
	|nuevoViajeroFrecuente|
	(unCliente verificarFrecuente) ifTrue: [
		nuevoViajeroFrecuente := unCliente hacerFrecuente.
		colClientes remove: unCliente.
		colClientes add: nuevoViajeroFrecuente. 
		].
	
]

{ #category : #inicializadores }
EmpresaTurismo >> iniConColClientes: cClientes yColViajes: cViajes [
	colClientes := cClientes.
	colViajes := cViajes.   
]

{ #category : #inicializadores }
EmpresaTurismo >> iniEmpresaTurismo [
colClientes := OrderedCollection new.
colViajes := OrderedCollection new.
]

{ #category : #aplicacion }
EmpresaTurismo >> obtenerViajesEntreFecha1: fe1 yFecha2: fe2 [
	^colViajes select: [:v | v verificarEntreFechasConFecha1: fe1 yFecha2: fe2].
]

{ #category : #aplicacion }
EmpresaTurismo >> pagarCuotasContratoConCantCuotasAPagar: cantCuotasAPagar yNroContrato: nroContrato [ 
	|contrato exito|	
	exito := false.
	contrato := 	self buscarContratoConNumero: nroContrato.	
	contrato ifNil: [ Transcript show: 'ERROR: Contrato no encontrado.'; cr.] ifNotNil: [
		exito  := contrato pagarCuotas: cantCuotasAPagar.
		].
	^exito 
]

{ #category : #aplicacion }
EmpresaTurismo >> realizarAltaViajeEspecialConNombre: nomViaje yCostoPorPersona: unCosto yImpuesto: unImpuesto yValorPlus: unValorPlus yCiudad: unaCiudad yFechaSalida: feSalida yFechaRegreso: feRegreso yDisponibilidad: disp [ 
	|unViaje|
	(self verificarExistenciaViaje: nomViaje) ifTrue: [^false] ifFalse:  [  
	unViaje := ViajeEspecial crearConNombre: nomViaje yCostoPorPersona: unCosto yImpuesto: unImpuesto  yValorPlus: unValorPlus yCiudad: unaCiudad yFechaSalida: feSalida yFechaRegreso: feRegreso yDisponibilidad: disp.
	colViajes add: unViaje.
	^true ]
]

{ #category : #aplicacion }
EmpresaTurismo >> realizarAltaViajeOrganizadoConNombre: unNombre yCostoPorPersona: unCosto yImpuesto: imp yValorPlus: unValorPlus yCantDiasDuracion: cantDias yEtapas: colEtapas yTuplasFechasSalidaCupos: tuplasFeCupos [
	|unViaje|
	(self verificarExistenciaViaje: unNombre) ifTrue: [^false] ifFalse: [ 
		unViaje := ViajeOrganizado crearConNombre: unNombre yCostoPorPersona:unCosto yImpuesto: imp yValorPlus: unValorPlus yCantDiasDuracion: cantDias yEtapas: colEtapas yFechasSalidaCupos: tuplasFeCupos.
	colViajes add: unViaje. 
	^true
		 ] 
	 
]

{ #category : #aplicacion }
EmpresaTurismo >> realizarAltaViajeOrganizadoConNombre: unNombre yCostoPorPersona: unCosto yImpuesto: imp yValorPlus: unValorPlus yCantDiasDuracion: cantDias yEtapas: colEtapas yTuplasFechasSalidaCupos: tuplasFeCupos yColExcursionesOpcionales: colExcOp [
	|unViaje|
	(self verificarExistenciaViaje: unNombre) ifTrue: [^false] ifFalse: [ 
		unViaje := ViajeOrganizado crearConNombre: unNombre yCostoPorPersona:unCosto yImpuesto: imp yValorPlus: unValorPlus yCantDiasDuracion: cantDias yEtapas: colEtapas yFechasSalidaCupos: tuplasFeCupos yExcursionesOpcionales:  colExcOp.
	colViajes add: unViaje. 
	^true
		 ] 
	 
]

{ #category : #aplicacion }
EmpresaTurismo >> realizarBajaViajeConNombre: unNombre [
	|unViaje ret|
	ret := false.
	unViaje := self buscarViaje: unNombre. 
	unViaje ifNil: [ Transcript show: 'ERROR: Viaje no encontrado.'; cr.] ifNotNil: [(unViaje verificarViajeRealizado) ifFalse: [ret := unViaje darDeBaja]].
	^ret
]

{ #category : #aplicacion }
EmpresaTurismo >> realizarInicioDelDia [	
	^ colClientes select: [:c | c tieneContratoAVencer]
]

{ #category : #aplicacion }
EmpresaTurismo >> reprogramarFecha: nroContrato conNuevaFecha: nuevaFecha [ 
	|contrato exito|
	exito := false.
	contrato := self buscarContratoConNumero: nroContrato.
	contrato ifNil: [ Transcript show: 'ERROR: Contrato no encontrado.'; cr.] ifNotNil: [exito := contrato reprogramarFecha: nuevaFecha].
	^exito

]

{ #category : #visualizadores }
EmpresaTurismo >> toStringColClientes [
	| cad |

   cad := '[ '.
	
  colClientes do: [:cliente |
    cad := cad , cliente getApellido, ', '.
].
cad := cad, ' ]'.
	^cad
]

{ #category : #visualizadores }
EmpresaTurismo >> toStringColViajes [
	| cad |

   cad := '[ '.
	
  colViajes do: [:viaje |
    cad := cad , viaje getNombre, ', '.
].
cad := cad, ' ]'.
	^cad
]

{ #category : #visualizadores }
EmpresaTurismo >> verContratosDeClientes [
	| cad |
   cad := 'Contratos: '.
	
  colClientes do: [:cliente |
    cad := cad, String cr, cliente getApellido,': ', cliente toStringColContratos.
].
	^cad
]

{ #category : #aplicacion }
EmpresaTurismo >> verificarCantidadCuotas: cantCuotas fechaViaje: fechaV [

	| fechaLimite fechaVencimiento |
	fechaLimite := fechaV subtractDays: 7.
	fechaVencimiento := Date today addDays: cantCuotas * 30.
	^ fechaVencimiento < fechaLimite
]

{ #category : #aplicacion }
EmpresaTurismo >> verificarClienteExistente: unDni [
	^colClientes anySatisfy: [:cadaCliente| cadaCliente verificarConDNI: unDni].
]

{ #category : #aplicacion }
EmpresaTurismo >> verificarExistenciaViaje: nomViaje [
	^colViajes anySatisfy: [:cadaViaje | cadaViaje verificarViaje: nomViaje]. 
]
