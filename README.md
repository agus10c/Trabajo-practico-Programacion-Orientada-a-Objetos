Trabajo Práctico Obligatorio Final de la materia Programación Orientada a Objetos — FAI, Universidad Nacional del Comahue.

Sistema desarrollado en Pharo 10 para la gestión de una empresa de turismo, que permite administrar clientes, viajes, contratos y excursiones, 
con interfaz gráfica implementada bajo el patrón Modelo-Vista. 

Para este trabajo se realizaro un diagrama de clases y de los diagramas de secuencia correspondientes

Funcionalidades implementadas

Gestión de viajes


Altas, bajas y modificaciones de viajes especiales y viajes organizados
Consulta de viajes disponibles en un rango de fechas
Gestión de etapas para viajes organizados (ciudad, hotel, tipo de pensión, actividades)


Gestión de contratos


Generación de nuevos contratos (viaje, fecha, cantidad de personas)
Pago de cuotas con vencimientos cada 30 días
Contrato flexible: reprogramación de fecha con pago de plus y cancelación con reembolso según anticipación:

Más de 3 meses antes → 75% del valor total
Entre 2 y 3 meses antes → 50% del valor total
Menos de 2 meses antes → 25% del valor total



Efectivización y cancelación de contratos
Agregado de excursiones opcionales hasta 1 semana antes del viaje


Gestión de clientes


Registro de clientes con historial completo de contratos
Sistema de preferencias para envío de información de nuevos paquetes
Viajero Frecuente: acumulación de millas por contratos efectivizados, utilizables para cancelar el 10% de un contrato. En caso de cancelación, el reembolso se realiza en millas


Inicio del día: Revisión automática de contratos próximos a vencer con pago incompleto para envío de recordatorios


Interfaz gráfica
Implementada con el framework Modelo-Vista de Pharo (dependientes, métodos changed y update)
La interfaz gráfica sigue el patrón Modelo-Vista de Pharo mediante el mecanismo de dependientes: 
el modelo notifica a las vistas registradas a través de changed: y las vistas se actualizan mediante update:.




