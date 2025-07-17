---
![Logo de Polkadot](img/Polkadot_Logo.png "Logo de Polkadot")
# 🚀 Tu Primer Nodo Polkadot en la Nube 🚀

Vamos a correr un nodo de una **parachain de ejemplo**. Este nodo simulará ser parte de la red Polkadot, permitiéndonos ver cómo funcionan estas conexiones.

---
## 1. Configurando nuestro Entorno: GitHub Codespaces

Para que no tengas que instalar nada en tu computadora, vamos a usar **GitHub Codespaces**. Esto nos da un entorno de desarrollo completo en la nube, accesible desde tu navegador.

**Paso a paso:**

1.  **Crear un Codespace:**
    * Primero vamos a hacer un fork del repositorio.
    * Una vez que ya tienes tu fork hacemos click en la pestaña code
    * Selecciona la pestaña **"Codespaces"**.
    * Hagan clic en **"Create codespace on main"**.

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
    chmod +x install.sh
    ```
3.  **Ejecuta el Script:**
    ```bash
    ./install.sh
    ```

El script mostrará un "spinner" y mensajes de progreso. Esto tomará varios minutos, Es normal que parezca que no pasa nada por un momento, pero el spinner te indicará que está trabajando.

---
## 3. Compilando y Corriendo Nuestro Nodo de Parachain

Una vez que el script haya terminado (verás "✔ ... completado." al lado de cada paso), eso significa que el script ya clonó la plantilla de la parachain y la compiló.

El último paso del script es iniciar el nodo. Si todo salió bien, verás algo como esto:

```bash
2025-07-16 12:22:37 [Parachain] Consensus with no RPC sender success: CreatedBlock { hash: 0xf47794a6d1acce74499922e674ecad1dc5f33704585ee0f6be9ab772708708d7, aux: ImportedAux { header_only: false, clear_justification_requests: false, needs_justification: false, bad_justification: false, is_new_best: true }, proof_size: 0 }    
2025-07-16 12:22:37 [Parachain] 🏆 Imported #0 (0xb316…42f2 → 0xf477…08d7)    
2025-07-16 12:22:37 [Parachain] 💤 Idle (0 peers), best: #0 (0xf477…08d7), finalized #0 (0xf477…08d7), ⬇ 0 ⬆ 0    
2025-07-16 12:22:40 [Parachain] 🙌 Starting consensus session on top of parent 0xf47794a6d1acce74499922e674ecad1dc5f33704585ee0f6be9ab772708708d7 (#0)    
```
