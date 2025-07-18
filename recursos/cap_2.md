---
# 🌐 Paso 2: Interactuando con tu Nodo 🌐

Ahora vamos a usar **Polkadot.js Apps**, la interfaz de usuario más común para interactuar con blockchains basadas en Substrate, para visualizar tu red y ejecutar operaciones.

---

## 1. Conectando Polkadot.js Apps a tu Nodo 🔌

Para interactuar con tu nodo de parachain que corre en Codespaces, primero necesitas conectarlo a Polkadot.js.

---

## Puertos

Como veras en el siguiente paso tenemos 3 puertos expuestos :

* **`9944`**: RPC WebSocket (JSON-RPC)
* **`9615`**: Prometheus Exporter / Métricas
* **`30333`**: P2P (Peer-to-Peer)

Proposito y uso:

### 1. Puerto `9944`: RPC WebSocket

* **Propósito:** Es tu interfaz principal para interactuar con la blockchain. Permite que aplicaciones como Polkadot.js, dApps o scripts se conecten y envíen o reciban datos del nodo.
* **Uso:** Consultar el estado de la cadena y enviar transacciones.

### 2. Puerto `9615`: Prometheus Exporter / Métricas

* **Propósito:** Exponer métricas de rendimiento y salud de tu nodo para herramientas de monitoreo  como Prometheus o  Grafana.
* **Uso:** Recopilar datos como uso de CPU/memoria, peers conectados, y velocidad de procesamiento de bloques para análisis y depuración.

### 3. Puerto `30333`: P2P (Peer-to-Peer)

* **Propósito:** La comunicación principal de tu nodo con **otros nodos**.
* **Uso:** Descubrimiento de peers, sincronización de bloques y propagación de transacciones para mantener la red actualizada.


### Pasos para la Conexión:

1.  **Abre el Puerto 9944 de tu Codespace:**
    * En tu GitHub Codespace, ve a la pestaña **"PORTS"** en la parte inferior de la ventana de VS Code.
    * Abriremos el puerto **`9944`** este es el puerto de WebSocket RPC de tu nodo.
    * Asegúrate de que la **"Visibility"** para este puerto esté configurada como **"Public"**. Si no lo está, haz clic derecho en el puerto y cambia la visibilidad a publico.
    * **Copia la "Forwarded Address"** (link) para el puerto `9944`.

2.  **Accede a Polkadot.js Apps:**
    * Abre una **nueva pestaña** en tu navegador y ve a: [https://polkadot.js.org/apps/](https://polkadot.js.org/apps/)

3.  **Conecta la Aplicación a tu Nodo:**
    * Haz clic en el **logo de Polkadot** en la esquina superior izquierda.
    * En la ventana de conexión, busca la sección **"Development"**.
    * Selecciona la opción **"Local Node (127.0.0.1:9944)"**.
    * En el campo de texto a la derecha, **borra lo que haya y pega la "Forwarded Address"** que copiaste de tu Codespace. Reemplaza el `https://` por `wss://` (WebSocket Secure).
    * Haz clic en el botón **"Switch"** en la parte inferior.
---

## 2. Parachain con Polkadot.js

Polkadot.js te ofrece una visión detallada mediante su interfaz de lo que sucede en tu blockchain.

### 2.1 Visión General del "Explorer"

La pestaña **"Network" > "Explorer"** es tu panel de control principal.

* **Bloques Recientes:** Verás cómo se importan nuevos bloques (`Imported Block #X`) en tiempo real.
* **Tiempo de Bloque:** Observa el tiempo transcurrido entre cada bloque.
* **Eventos y Extrinsics:** Aunque tu parachain de ejemplo no tendrá mucha actividad al principio, esta sección muestra las transacciones (extrinsics) y los eventos que se producen en cada bloque.
* **Conexión de Peers:** En la parte superior derecha, verás `0 peers` (o un número bajo). Esto es normal para un nodo local o en un Codespace aislado en una red real, se conectaría a muchos más.

### 2.2 Administrando Cuentas (`Accounts`)

En la pestaña **"Accounts"**, puedes gestionar las cuentas de tu red.
