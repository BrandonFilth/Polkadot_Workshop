![Logo de Polkadot](/img/polkadotLogo.png "Logo de Polkadot")

# Interactuando con tu blockchain
Ahora que tienes cuentas, vamos a realizar una transferencia simple para ver la interaccion con tu parachain. El objetivo sera enviar algunos MUNIT desde una de las cuentas de desarrollo por ejemplo Alice a tu cuenta recien añadida.

![Transfer](/img/jsTransfer.png)
* Haz clic en el boton "enviar": A la derecha del nombre de Alice y su saldo
* "send from account": Deberia estar preseleccionada Alice.
* "send to address": Aqui debes pegar la direccion SS58 de tu cuenta o seleccionar una.
* "amount": Ingresa una cantidad de tokens a transferir por ejemplo,  `1000000000000 ` si quieres enviar 1 MUNIT ya que MUNIT es una unidad con 12 decimales por defecto, o simplemente envia 1 UINT (MUNIT completo equivale a 1,000,000,000,000 (1 billon) de la unidad base UNIT).
*  Enviamos la transaccion.

![Transfer](/img/jsFirma.png)
* `balances.transferAllowDeath`: Es el nombre del extrinsic que se va a ejecutar el cual permite enviar tokens y el sufijo AllowDeath indica que esta transferencia puede resultar en la purga de la cuenta de origen si su saldo cae por debajo del deposito existencial y no tiene otras referencias.
* `Fees of 1.4751 MUNIT will be applied to the submission`: Esta es la tarifa de transaccion que se deducira de la cuenta que envia para procesar esta operacion en la red.
* `call hash`: Es un identificador unico del extrinsic, es como una huella digital de la instruccion que se enviara a la blockchain.

![Transfer](/img/jsSend.png)

* Debajo de esta notificacion de finalizacion, veras una lista de los eventos clave que ocurrieron como resultado de tu transaccion como balances.Withdraw (fondos retirados de Alice), balances.Transfer (la transferencia), balances.Deposit (fondos depositados en Nigromante) y transactionPayment.TransactionFeePaid (tarifa de transaccion).


### Transaccion enviada
Puedes realizar mas transferencias entre cuentas y si vamos a la ventana del explorador en el apartado de eventos podremos ver nuestras transacciones detalladamente.

![Extrinsic](/img/jsEvento.png)

* `"eventos recientes"` : Aqui puedes ver la lista de eventos que han ocurrido en la red.
* `balances.Transfer`: Este es el tipo de evento que se muestra.
* `Transfer succeeded`: Indica que la operacion de transferencia fue exitosa.

![Extrinsic](/img/jsTransferDetails.png)

Tambien podemos ver los datos del extrinsic detalladamente de cada evento ocurrido:
* `parachainSystem.setValidationData`: Es una operacion interna que se encarga de actualizar la informacion que los validadores de la red usan para verificar la validez de los bloques y el estado de la red.
* `timestamp.set`: Registra la marca de tiempo del bloque permitiendo que todas las transacciones dentro de este bloque tengan una marca de tiempo.
* `balances.transferKeepAlive`: Es una funcion para transferir fondos de una cuenta a otra que permite mantener viva la cuenta incluso si la cuenta de origen queda con un balance muy bajo.
* `Eventos`: como puedes ver tenemos una secuencia de eventos los cuales son:  `balances.Withdraw > balances.Transfer > balances.Deposit > transactionPayment.TransactionFeePaid > system.ExtrinsicSucces `.
* `Weight`: Es una unidad que mide el consumo de recursos la cual incrementa si se require mayor complejidad computacional, mas almacenamiento o mayor tamaño de datos.
* `Fee`: Es la tarifa de transaccion la cual puede aumentar si el `weight` es mayor, si la red esta congestionada (con mucha carga) y por ultimo, si se añade una propina adicional para que la transaccion sea procesada mas rapidamente.

--- 
## Estado de la cadena 
Si nos dirigimos a la pestaña `"Desarrolladora">"Estado de la cadena"` en este lugar podemos consultar el estado actual de la red, en la sub-pestaña "Almacenamiento" podemos consultar valores almacenados en el runtime, este apartado tiene muchas funciones y datos que puedes consultar pero para este curso solamente veremos .

![Extrinsic](/img/almacenamiento.png)

Como podemos observar tenemos las siguientes funciones:
* `balances.totalIssuance(): u128`: Muestra la cantidad de tokens que se han emitido hasta el momento.
* `balances.reserved`: Fondos reservados, son tokens que **pertenecen a una cuenta, pero que estan bloqueados o comprometidos para un proposito especifico** y no pueden ser transferidos ni gastados.
* `balances.palletVersion`: Indica la **version actual del "pallet" (modulo) de `balances`** que esta activo en el *runtime* de la blockchain.
* `balances.locks`: Representa restricciones especificas sobre el balance de una cuenta. A diferencia de los fondos reservados, los "locks" pueden ser impuestos por diversas razones y **pueden impedir que una porcion del saldo sea transferida o incluso gastada**, aunque siga siendo parte del saldo total de la cuenta. Un ejemplo comun es un bloqueo por *staking* o por alguna propuesta de gobernanza.
* `balances.inactiveIssuance`: Se refiere a una parte del suministro total de tokens que, por alguna razon, **no esta considerada como "activa" en la circulacion o en el suministro total calculable**.
* `balances.holds y balances.freezes`: Estos son mecanismos adicionales para retener o inmovilizar una parte del balance de una cuenta. Aunque similares a "reserved" o "locks", pueden tener **propositos o logicas distintas definidas en el *runtime***.
* `balances.account`: Muestra los datos de la cuenta AccountId32 que se haya consultado.

## Extrinsics 
Un "extrinsic" es una instruccion o una llamada a una funcion dentro del runtime (la logica central) de nuestra blockchain. A traves de los extrinsics, los usuarios y administradores pueden interactuar con la cadena para realizar operaciones como transferir fondos, votar en propuestas, o, como veremos aqui, incluso actualizar el codigo de la blockchain.

### Huella en cadena

Mas alla de las transferencias de fondos, una blockchain tambien permite registrar otros tipos de informacion de manera inmutable, por ejemplo el extrinsic `system.remark` el cual te permite añadir datos directamente en la blockchain algo asi como escribir una nota o un mensaje.

![Remark](/img/jsRemark.png)

* Seleccionamos la cuenta emisora
* Elegiremos la pallet `system` y el extrinsic `remark`
* Añadimos un mensaje cualquiera.
* "Enviar con firma" asegura que la transaccion proviene del propietario de la cuenta y cubre tarifas. "Enviar sin firma" se usa para operaciones de sistema o donde otro paga la tarifa, sin autenticacion directa del remitente.

### Detalles tecnicos: 
* `encoded call data`: Esto es la representacion en formato hexadecimal puro de la llamada al extrinsic que se enviara. Es la instruccion codificada, que los nodos de la red interpretaran.
* `encoded call hash`: Este es el hash criptografico unico funciona como una huella digital.
* `encoding details`: Proporciona una vista legible de los datos codificados, confirmando que es una llamada al modulo system, metodo remark, con el valor "hola mundo" (mostrado en hexadecimal).

Mas alla de funciones como system.remark, la pestaña "Extrinsics" te permite acceder a una amplia gama de funciones ("calls") de diferentes "pallets" (modulos) de tu runtime. Por ejemplo, dentro del pallet system, encontramos funciones para gestionar el codigo del runtime (setCode) o limpiar almacenamiento (killPrefix).

![Remark](/img/jsRemark.png)
Desde esta misma seccion podemos realizar transferencias de fondos. Si seleccionas el pallet balances (visible en el menu desplegable), encontraras funciones como:

*  `transfer(dest, value)`: Para enviar una cantidad especifica de tokens a una direccion de destino.

* `transferAll(dest, keepAlive)`: Para transferir todos los fondos disponibles de tu cuenta a un destino, opcionalmente dejando un balance minimo para mantener la cuenta viva.

*  `burn(value, keepAlive)`: Para quemar (destruir) fondos de tu cuenta.

👉[Capitulo 4](/recursos/cap_4(CifradoSubkey).md)
---
