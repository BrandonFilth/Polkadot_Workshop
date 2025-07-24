![Logo de Polkadot](/img/polkadotLogo.png "Logo de Polkadot")

# Tu Primer Nodo Polkadot en la Nube

## 1. Configurando nuestro Entorno: GitHub Codespaces

Para que no tengas que instalar nada en tu computadora, vamos a usar **GitHub Codespaces**. Esto nos da un entorno de desarrollo completo en la nube, accesible desde tu navegador.

**Paso a paso:**

1.  **Crear un Codespace:**
    * Primero vamos a hacer un fork del repositorio.
    * Una vez que ya tienes tu fork hacemos click en la pestaña code
    * Selecciona la pestaña **"Codespaces"**.
    * Has clic en **"Create codespace on main"**.

    Esto tomará unos minutos mientras GitHub prepara tu entorno de desarrollo. Verás una pantalla de carga y luego se abrirá una versión de Visual Studio Code directamente en tu navegador.

---
## 2. Instalando Dependencias y Herramientas de Polkadot

Ahora que tenemos nuestro Codespace listo, vamos a usar un script para instalar todo lo que necesitamos. Este script se encargará de:

* Actualizar los paquetes del sistema.
* Instalar herramientas de compilación como `build-essential`, `clang`, `git`, `make`.
* Instalar **Rust**, el lenguaje de programación principal con el que se construye Polkadot.
* Configurar la versión de Rust necesaria y añadir el soporte para **WASM** (WebAssembly), que es como se compilan los "runtimes" de las blockchains de Polkadot.
* Instalar herramientas de **Polkadot** como `staging-chain-spec-builder` y `polkadot-omni-node`.
* Clonar el **Parachain Template**, que es una plantilla de código para crear nuevas parachains.

**Ejecución del script**

1.  **Abre la Terminal:** Dentro de tu Codespace, busca la terminal. Generalmente, está en la parte inferior. Si no la ves, puedes ir al menu de la esquina superior izquierda > `Terminal > New Terminal` en el menú superior.
2.  **Añade los Permisos de Ejecución:**
    ```bash
    chmod +x script.sh
    ```
3.  **Ejecuta el Script:**
    ```bash
    ./script.sh
    ```

El script mostrará un "spinner" y mensajes de progreso. Esto tomará varios minutos, Es normal que parezca que no pasa nada por un momento, pero el spinner te indicará que está trabajando.

---
## 3. Compilando y Corriendo Nuestro Nodo 

Una vez que el script haya terminado verás "✔ ... completado." al lado de cada paso, eso significa que el script ya clonó la plantilla de la parachain y la compiló.

El último paso del script es iniciar el nodo. Si todo salió bien, verás algo como esto:

```bash
2025-07-17 10:47:14 polkadot-omni-node    
2025-07-17 10:47:14 ✌️  version 1.18.0-unknown    
2025-07-17 10:47:14 ❤️  by Parity Technologies <admin@parity.io>, 2017-2025    
2025-07-17 10:47:14 📋 Chain specification: Custom    
2025-07-17 10:47:14 🏷  Node name: humorous-quill-0949    
2025-07-17 10:47:14 👤 Role: AUTHORITY    
2025-07-17 10:47:14 💾 Database: RocksDb at /tmp/substratewQmkPH/chains/custom/db/full    
2025-07-17 10:47:19 assembling new collators for new session 0 at #0    
2025-07-17 10:47:19 assembling new collators for new session 1 at #0    
2025-07-17 10:47:26 [Parachain] assembling new collators for new session 0 at #0    
2025-07-17 10:47:26 [Parachain] assembling new collators for new session 1 at #0    
2025-07-17 10:47:30 [Parachain] 🔨 Initializing Genesis block/state (state: 0xe2dc…735a, header-hash: 0x2690…8a63)    
2025-07-17 10:47:30 [Parachain]  creating SingleState txpool Limit { count: 8192, total_bytes: 20971520 }/Limit { count: 819, total_bytes: 2097152 }.    
2025-07-17 10:47:30 [Parachain] Using default protocol ID "sup" because none is configured in the chain specs    
2025-07-17 10:47:30 [Parachain] 🏷  Local node identity is: 12D3KooWAhZpTTNJ2a8HzWgdnp7oig5B727TdE474U3VkZmZLrFG    
2025-07-17 10:47:30 [Parachain] Running libp2p network backend    
2025-07-17 10:47:30 [Parachain] local_peer_id=12D3KooWAhZpTTNJ2a8HzWgdnp7oig5B727TdE474U3VkZmZLrFG
2025-07-17 10:47:30 [Parachain] 💻 Operating system: linux    
2025-07-17 10:47:30 [Parachain] 💻 CPU architecture: x86_64    
2025-07-17 10:47:30 [Parachain] 💻 Target environment: gnu    
2025-07-17 10:47:30 [Parachain] 💻 CPU: AMD EPYC 7763 64-Core Processor    
2025-07-17 10:47:30 [Parachain] 💻 CPU cores: 1    
2025-07-17 10:47:30 [Parachain] 💻 Memory: 7938MB    
2025-07-17 10:47:30 [Parachain] 💻 Kernel: 6.8.0-1027-azure    
2025-07-17 10:47:30 [Parachain] 💻 Linux distribution: Ubuntu 24.04.2 LTS    
2025-07-17 10:47:30 [Parachain] 💻 Virtual machine: yes    
2025-07-17 10:47:30 [Parachain] 📦 Highest known block at #0    
2025-07-17 10:47:30 [Parachain] 〽️ Prometheus exporter started at 127.0.0.1:9615    
2025-07-17 10:47:30 [Parachain] Running JSON-RPC server: addr=127.0.0.1:9944,[::1]:9944    
2025-07-17 10:47:31 [Parachain] Failed to trigger bootstrap: No known peers.
2025-07-17 10:47:33 [Parachain] 🙌 Starting consensus session on top of parent 0x2690d9cab2ac4a0c12f4f04c16ee6fafeed8162743acc6ce2cfeaf7f1c0d8a63 (#0) 
2025-07-17 10:47:33 [Parachain] 🎁 Prepared block for proposing at 1 (1 ms) hash: 0xf6147dd5ac08a4da976e2f655599acd50cc1074e3199e3935218cb277a8fa3e5; parent_hash: 0x2690…8a63; end: NoMoreTransactions; extrinsics_count: 2    
2025-07-17 10:47:33 [Parachain] Consensus with no RPC sender success: CreatedBlock { hash: 0xf6147dd5ac08a4da976e2f655599acd50cc1074e3199e3935218cb277a8fa3e5, aux: ImportedAux { header_only: false, clear_justification_requests: false, needs_justification: false, bad_justification: false, is_new_best: true }, proof_size: 0 }
2025-07-17 10:47:33 [Parachain] 🏆 Imported #1 (0x2690…8a63 → 0xf614…a3e5)    
2025-07-17 10:47:35 [Parachain] 💤 Idle (0 peers), best: #1 (0xf614…a3e5), finalized #1 (0xf614…a3e5), ⬇ 0 ⬆ 0    
2025-07-17 10:47:36 [Parachain] 🙌 Starting consensus session on top of parent 0xf6147dd5ac08a4da976e2f655599acd50cc1074e3199e3935218cb277a8fa3e5 (#1)  
```
---
### Salida del Nodo

Si tu nodo está funcionando correctamente, verás una serie de mensajes en la terminal. Aquí te explico qué significan los más importantes:

* **`Imported #X`**: Este mensaje indica que tu nodo ha procesado y validado un **nuevo bloque** con el número `X`. Cada bloque contiene las últimas transacciones y el estado de la cadena, y su importación significa que tu nodo está al corriente con la cadena.
* **`Idle (0 peers)`**: Esto significa que tu nodo está activo, pero **aún no se ha conectado a otros nodos** en la red. En un entorno de desarrollo local o en un Codespace aislado, como este, es completamente normal ver `0 peers`. En una red Polkadot real, este número aumentaría a medida que tu nodo descubra y se conecte a otros nodos para sincronizar el estado de la cadena.
* **`Starting consensus session`**: Este mensaje muestra que el nodo está **participando activamente en el proceso de consenso**. Esto es clave para las parachains, ya que les permite proponer o validar nuevos bloques que eventualmente serán finalizados por la [Relay Chain](/recursos/conceptos/RelayChain.md).

### **Manten la terminal abierta** Tu nodo debe seguir ejecutándose para que podamos interactuar con él en los siguientes pasos. No cierres la ventana ni detengas el proceso.

👉 [Capitulo 2](/recursos/cap_2(ConexionJs).md)
---

