![Logo de Polkadot](/img/polkadotLogo.png "Logo de Polkadot")

# Conectando Polkadot.js a tu Nodo 🔌🌐

Ahora vamos a usar **Polkadot.js**, la interfaz de usuario mas comun para interactuar con blockchains basadas en Substrate, para visualizar tu red y ejecutar operaciones.
Para interactuar con tu nodo de parachain que corre en Codespaces, primero necesitas conectarlo a Polkadot.js.

---

## 1. Puertos

#### Como puedes ver tenemos 3 puertos expuestos:

!["Puertos"](/img/puertosej.png)

## Proposito y uso:
### Puerto `9944`: RPC WebSocket
* **Proposito:** Es tu interfaz principal para interactuar con la blockchain. Permite que aplicaciones como Polkadot.js, dApps o scripts se conecten y envien o reciban datos del nodo.
* **Uso:** Consultar el estado de la cadena y enviar transacciones.

### Puerto `9615`: Metricas
* **Proposito:** Exponer metricas de rendimiento y salud de tu nodo para herramientas de monitoreo  como Prometheus o  Grafana.
* **Uso:** Recopilar datos como uso de CPU/memoria, peers conectados, y velocidad de procesamiento de bloques para analisis y depuracion.

### Puerto `30333`: P2P (Peer-to-Peer)
* **Proposito:** La comunicacion principal de tu nodo con otros nodos.
* **Uso:** Descubrimiento de peers, sincronizacion de bloques y propagacion de transacciones para mantener la red actualizada.
---

## Pasos para la Conexion:

* Abre el Puerto 9944 de tu Codespace:
* En tu GitHub Codespace, ve a la pestaña **"PORTS"** en la parte inferior de la ventana de VS Code.
* Abriremos el puerto **`9944`** este es el puerto de WebSocket RPC de tu nodo.
* Asegurate de que la **"Visibility"** para este puerto este configurada como **"Public"**. Si no lo esta, haz clic derecho en el puerto y cambia la visibilidad a publico.
* **Copia la "Forwarded Address"** (link) para el puerto `9944`.

!["Puertos"](/img/puertos.png)

### 2. **Accede a Polkadot.js:**
* Abre una **nueva pestaña** en tu navegador y ve a: [https://polkadot.js.org/apps/](https://polkadot.js.org/apps/)

![PolkadotJS](/img/polkadot.png)

### 3. **Conecta la Aplicacion a tu Nodo:**
* Haz clic en el **logo de Polkadot** en la esquina superior izquierda.
* En la ventana de conexion, busca la seccion **"Development"**.
* Selecciona la opcion **"Local Node (127.0.0.1:9944)"**.

![PolkadotWss](/img/wss.png)

* En el campo de texto a la derecha, **borra lo que haya y pega la "Forwarded Address"** que copiaste de tu Codespace. Reemplaza el `https://` por `wss://` (WebSocket Secure).
* Haz clic en el boton **"Switch"** en la parte inferior.

![PolkadotSw](/img/switch.png)

---

# 2. Parachain con Polkadot.js

### Vision General del "Explorer"

![Explorer](/img/jsexplorer.png)

La pestaña **"Network" > "Explorer"** es tu panel de control principal.
* **Bloques Recientes:** Veras como se importan nuevos bloques en tiempo real.
* **Tiempo de Bloque:** El tiempo transcurrido entre cada bloque.
* **Eventos y Extrinsics:** a seccion "eventos recientes" mostrara los eventos que se emiten en la cadena, los cuales estan asociados a las transacciones (extrinsics) que se producen en cada bloque.
* **Metricas en cadena:** En la parte superior podemos ver la cantidad de tokens emitidos y la inactive issuance la cual indica cuantos tokens estan inactivos.
---

### Administrando Cuentas (`Accounts`)

En la pestaña **"Accounts"**, puedes gestionar las cuentas de tu red. Como puedes observar en la interfaz de Polkadot.js, ya tenemos varias cuentas de desarrollo preañadidas y con tokens disponibles, los cuales puedes transferir y usar para pagar las tarifas de gas en la red.

### Ve a "Accounts" > "Accounts" Aqui veras un listado de cuentas:
Tu parachain, al estar basada en Substrate, viene con un conjunto de cuentas de desarrollo predefinidas (Alice, Bob, Charlie, etc.) cada una tendra un saldo inicial de tokens pre-minados para desarrollo.
![Accounts](/img/jsAcc.png/)



### Añadir una cuenta
Vamos a usar la funcionalidad de "Generador Vanity" para crear y añadir una nueva cuenta personalizada. Esta es una manera de obtener una direccion con un patron especifico que explicaremos mas adelante, por ahora solo generaremos una, para ello haz click en `Generator vanity` en la barra superior de navegacion:

![Vanity](/img/jsAccVanity.png)

* En el campo "busque por", ingresa el patron de caracteres que deseas que contenga tu direccion SS58.
* Vamos a elegir el par de claves criptograficas `Sr25519` el cual es mejor en cuanto a seguridad y eficiencia para la derivacion jerarquica.
* Guardamos la configuracion y comenzamos la generacion de wallets.

![Vanity](/img/vanity.png)

* La aplicacion comenzara a generar cientos de claves hasta encontrar una que coincida con tu patron, este proceso puede llevar tiempo asi que guardaremos una random haciendo click en el boton guardar.
* En la ventana emergente vamos a seleccionar la opcion de mnemonic la cual nos dara nuestras palabras de recuperacion y es el mejor formato para guardarlas, vamos a marcar la casilla de que las hemos guardado y seguimos.

![Vanity](/img/jsS1.ng.png)

* En la siguiente ventana vamos a ingresar un nombre y una contraseña la cual sera utilizada para cifrar localmente la clave privada de tu cuent, esta contraseña tambien sera requerida cada vez que quieras realiar una transaccion o firmar un mensaje,tambien sera utilizada para poder descifrar el archivo de despaldo JSON generado, en pocas palabras se usa como la verificacion de identidad dandole una capa extra de seguridad. 

![Vanity](/img/cuentaM.png)

Una vez que se complete la descarga puedes volver a la ventana principal y podras ver que tu cuenta se ha importado automaticamente y su saldo inicial sera de 0 UNIT.



👉[Capitulo 3](/recursos/cap_3(Extrinsics).md)
---                                                                                                            