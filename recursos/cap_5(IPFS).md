




##  Gestión y Carga de Archivos Locales en la Interfaz

Esta sección de la interfaz de Polkadot-JS Apps te permite gestionar archivos directamente en el almacenamiento local de tu navegador. Es particularmente útil para cargar configuraciones personalizadas, metadatos, o para interactuar con sistemas como IPFS.

### Que se puede hacer en esta seccion?
* Cargar archivos desde tu computadora 
* Importar datos directamente
* Exportar datos que ya estan en la lista local y descargarlos.
### Es importante acalarar que no se guardara la lista de archivos almacenados en la blockchain ni se sincronizan con otros dispositivos por lo cual estos se perderan si cambias de navegador sin haberlos almacenado antes.
--- 

![IPFS](/img/ipfsDot.png)

## Carga de archivos
* Haz click en el boton "Cargar" y selecciona el archivo que quieras subir.
* Selecciona un IPFS pinner: este servicio se encarga de mantener tu archivo en la red IPFS permitiendo que tu navegador se comunique con la red.
* Selecciona una cuenta para firmar la transaccion.
* Introduce tu contraseña (en caso de ser requerida).
* Firma la transaccion e inicia la carga.

![IPFS](/img/IPFSUpload.png)

## Que esta ocurriendo por detras?
* Calculo del hash IPFS: Al realizar la carga de un archivo tuiu navegador calcula el Content Identifier (CID) unico para el archivo, este CID es el hash criptografico del archivo.
* Envio al Gateway IPFS: Como podemos ver en el ejemplo el archivo al IPFS seleccionado en este caso "Crust Network(Seattle)" a travez de una conexion HTTPS, este gateway es el responsable de inyectar el archivo en la red IPFS.
* Creacion de la orden de Pinning en la blockchain: Suele ser un extrinsic como crust.placeStorageOrder (Si usamos Crust Network) esta transaccion tendra el CID del archivo IPFS, la informacion sobre el servicio de Pinning y los parametros para el pago por el pinning.
* Envio de la transaccion: La transacion firmada se envia a los nodos de tu red, los collators la incluyen en un bloque y los validadores la verifican.



## Carga completada

![IPFS](/img/IPFSdash.png)


Como puedes ver el archivo se encuentra cargado y fijado en la blockchain y aqui hay unos datos importantes a tomar en consideracion:
* File CID: Junto al nombre de tu archivo aparece su CID en mi caso es el `QmSREWRgbFPziQHe4DPR9gvzZR6xVsha2mxgWFyig7PSff`
* File size: Se muestra el tamaño del archivo en este caso `3130 bytes` este valor puede cambiar y no siempre sera el original si el archivo fue comprimido o paso por algun proceso interno de IPFS.
* Status: Como puedes observar mi archivo paso el proceso de pinning con exito y ya se encuentra en la red publica (no solo en testnet).

## Validacion de Pinning
Aunque estás en una red de prueba, Polkadot-JS Apps te permite interactuar con servicios reales como Crust Network. La interfaz envía la transacción de pinning a la red real de Crust, que luego fija tu archivo en IPFS, haciéndolo accesible globalmente.

Por lo cual si hacemos click en `View status in Crust` podremos acceder a la interfaz y ver como ha sido pinneado exitosamente.

![IPFS](/img/IPFSdash.png)
Como podemos observar aqui se confirma que se uso `Crust Pinner` para asegurar su almacenamiento persistente.
Recuerda que IPFS esta construido para ser un servicio de almacenamiento publico decentralzado por lo cual todo aquel que tenga tu CID puede acceder al contenido haciendo uso de un gateway.

Para visualizar tu archivo podemos usar el siguiente gateway:
```bash
https://ipfs.io/ipfs/
``` 
Añadimos nuestro CID `QmSREWRgbFPziQHe4DPR9gvzZR6xVsha2mxgWFyig7PSff`:
```bash
https://ipfs.io/ipfs/QmSREWRgbFPziQHe4DPR9gvzZR6xVsha2mxgWFyig7PSff
``` 

## Exportacion e importacion.
Por ultimo podemos exportar una lista de todos nuestros archivos cargados para asi no perder su registro y mentenerlos accesibles importandolos en nuestra siguiente sesion o cuando sea necesitado.

![IPFS](/img/IPFSExport.png)

Se nos descargara un archivo JSON con los datos para importar nuestra lista cuando sea necesario como el siguiente: 

```bash
[{"Name":"dot.png","Hash":"QmSREWRgbFPziQHe4DPR9gvzZR6xVsha2mxgWFyig7PSff","Size":"3138","PinEndpoint":"https://pin.crustcode.com","UpEndpoint":"https://gw.crustfiles.app"}]
``` 
* `"Name"`: El nombre original del archivo (`dot.png`).
* `"Hash"`: El CID (Content ID) de IPFS (`QmSREWRgbFPziQHe4DPR9gvzZR6xVsha2mxgWFyig7PSff`).
* `"Size"`: El tamaño del archivo (`3138` bytes).
* `"PinEndpoint"`: La URL del punto de conexión del servicio de *pinning* utilizado (`https://pin.crustcode.com`).
* `"UpEndpoint"`: La URL del *gateway* de subida utilizado (`https://gw.crustfiles.app`).

👉[Extra Js](/recursos/cap_6(JavaScript).md)
--- 