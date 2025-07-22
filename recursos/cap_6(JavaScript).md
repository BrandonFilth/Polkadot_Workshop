![Logo de Polkadot](/img/polkadotLogo.png "Logo de Polkadot")

## Java Script: Interaccion y ejecucion de extrinsics con eventos

La pestaña `Desarrolladora>JavaScript` podemos encontrar una consola de JavaScript en vivo donde puedes escribir y ejecutar codigo directamente usando el nodo de tu blockchain.
Este entorno te da acceso a:

* `API`: El objeto principal para interactuar con la cadena, permitiendote enviar extrincics (api.tx), realizar consultas de estado (api.query), o llamadas RPC (api.rpc).
* `Keyring`: Para gestionar y firmar transacciones con tus cuentas.
* `Hashing, types, util`: Utilidades para operaciones criptograficas, manejo de tipos de datos Substrate y funciones auxiliares.
---
## Ejemplo 1 (Make transfer and listen to events):
Este ejemplo (Make transfer and listen to events) demuestra cómo enviar una transacción de transferencia de tokens y, crucialmente, cómo escuchar y procesar los eventos que la blockchain emite una vez que la transacción ha sido incluida en un bloque

![IPFS](/img/extraTransfer.png)

Funciones Clave:
- `api.tx.balances.transferAllowDeath(BOB, randomAmount)`: Construye un extrincic para transferir una cantidad de tokens a la cuenta BOB.
- `await transfer.signAndSend(ALICE, ({ events = [], status }) => { ... })`: Firma la transaccion con la cuenta ALICE y la envia a la cadena. La funcion de callback se ejecuta cada vez que el estado de la transaccion cambia (ej. Ready, Finalized) y cuando se reciben eventos.

Eventos Explicados (Salida del panel derecho):

- `Status of transfer: Ready`: La transaccion ha sido enviada al pool de transacciones del nodo y esta lista para ser incluida en un bloque.
- `Status of transfer: Finalized`: La transaccion ha sido incluida en un bloque y ese bloque ha sido finalizado (confirmado irreversiblemente por la cadena).
- `balances.Withdraw`: Se emite cuando se retiran fondos de una cuenta (en este caso, de ALICE al enviar la transferencia).
- `balances.Transfer`: Se emite confirmando que una transferencia de fondos entre dos cuentas ha ocurrido exitosamente.
- `balances.Deposit`: Se emite cuando se depositan fondos en una cuenta (en este caso, en la cuenta de BOB).
- `transactionPayment.TransactionFeePaid`: Indica que se ha pagado una tarifa de transaccion.
- `system.ExtrinsicSuccess`: El evento mas importante, confirma que el extrincic (la transferencia) se ejecuto con exito sin errores en el runtime.

---
## Ejemplo 2 (Get state metadata):
Cuando ejecutas el ejemplo "Get state metadata" en la consola de JavaScript, la salida te proporciona una representación estructurada de la API de tu blockchain.
![IPFS](/img/extraMetadata.png)


¿Como pueden los desarrolladores usar esta informacion?

La metadata es la base para interactuar programaticamente con cualquier cadena Substrate. Los desarrolladores la usan para:

- `Decodificacion de Datos en Crudo`: Cuando consultas el estado de la cadena como el balance de una cuenta o recibes eventos, la blockchain te devuelve datos en formato binario (bytes).
- `Construccion de Transacciones`: Para enviar extrincics (transacciones), necesitas saber que parametros esperan las funciones.
- `Generacion de Clientes y SDKs`: Herramientas como @polkadot/api utilizan esta metadata para generar dinamicamente el API de JavaScript que usas para interactuar con la cadena (api.query.pallet.storageItem, api.tx.pallet.extrinsicCall). Sin la metadata, seria imposible que estos clientes supieran como interactuar con una cadena generica de Substrate.
- `Desarrollo de Interfaces de Usuario (UIs)`: Al construir una UI personalizada, la metadata permite que la aplicacion entienda que pallets existen, que extrincics se pueden llamar, que eventos se pueden escuchar y como mostrar los datos de la cadena de forma legible.
- `Depuracion y Auditoria`: Si un extrincic falla o un estado es incorrecto, la metadata ayuda a entender la estructura de los datos que se estan manejando, facilitando la depuracion.
- `Compatibilidad y Actualizaciones`: Monitorear la version de la metadata es vital para asegurar que las aplicaciones externas sigan siendo compatibles despues de una actualizacion del runtime de la blockchain.

---
## Ejemplo 3 (Listen to multiple balances changes):

Demuestra cómo suscribirse a las actualizaciones de estado de una o varias cuentas. Esto significa que cada vez que el balance o la información de la cuenta (como el nonce) de las direcciones monitoreadas cambie, tu código recibirá una notificación con la información actualizada.

![IPFS](/img/extraMetadata.png)

El codigo principal utiliza api.query.system.account.multi([ALICE, BOB], (infos) => { ... }).

- `api.query`: Se usa para realizar consultas al estado de la blockchain.
- `system.account`: Es la consulta para obtener la informacion de una cuenta especifica del pallet system.
- `.multi([ALICE, BOB])`: Permite suscribirse a multiples cuentas (ALICE y BOB en este caso) simultaneamente.
- `(infos) => { ... }`: Esta es la funcion de callback que se ejecuta cada vez que hay un cambio en la informacion de cualquiera de las cuentas monitoreadas. El parametro `infos` contendra un array con los datos actualizados de todas las cuentas monitoreadas.

Como podemos ver en la consola tenemos los siguientes datos:

```bash
Tracking balances for: [5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY, 5FHneW46xGXgs5mUiveU4sbTyGBzmstUspZC92UhjJM694ty]

Change detected, new balances: [{nonce: 3, consumers: 1, providers: 1, sufficients: 0, data: {free: 1152921500261676599, reserved: 0, frozen: 0, flags: 170141183460469231731687303715884105728}}, {nonce: 0, consumers: 1, providers: 1, sufficients: 0, data: {free: 1152921504606973915, reserved: 0, frozen: 0, flags: 170141183460469231731687303715884105728}}]

Change detected, new balances: [{nonce: 4, consumers: 1, providers: 1, sufficients: 0, data: {free: 1152911498776774322, reserved: 0, frozen: 0, flags: 170141183460469231731687303715884105728}}, {nonce: 0, consumers: 1, providers: 1, sufficients: 0, data: {free: 1152921504606973915, reserved: 0, frozen: 0, flags: 170141183460469231731687303715884105728}}]
``` 
- `nonce`: Es el numero de extrincics (transacciones) validos que ha enviado esa cuenta. Se incrementa cada vez que una transaccion de la cuenta se incluye en un bloque.
- `consumers, providers, sufficients`: Estos campos estan relacionados con el sistema de "referencia de cuentas" de Substrate. Ayudan a la cadena a determinar si una cuenta debe mantenerse viva (tener un "deposito existencial") o puede ser eliminada del almacenamiento para ahorrar espacio.
- `consumers`: Indica cuantas "cosas" (otras cuentas o modulos) dependen de la existencia de esta cuenta por ejemplo; si esta cuenta tiene fondos bloqueados por un smart contract.
- `providers`: Indica cuantas "cosas" le proveen fondos a esta cuenta.
- `sufficients`: Un contador para la eficiencia del almacenamiento.
- `data`: Este objeto contiene la informacion de los balances:
- `free`: El balance de tokens disponible para gastar o transferir. Veras que los numeros son muy grandes como "1152921500261676599". Esto se debe a que la blockchain almacena los balances como numeros enteros muy grandes (generalmente u128) para evitar problemas de coma flotante y para manejar la precision de los decimales de tu token.
- `reserved`: Fondos que estan bloqueados o reservados para un proposito especifico (ej., participacion en staking, depositos por contratos, etc.). No se pueden gastar.
- `frozen`: Fondos que estan bloqueados o congelados.
- `flags`: Banderas internas relacionadas con el estado de la cuenta.


---
