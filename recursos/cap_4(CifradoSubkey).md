![Logo de Polkadot](/img/polkadotLogo.png "Logo de Polkadot")

# Criptografia Asimetrica: Fundamentos y Aplicacion con `Subkey`

###  Primero que nada tenemos que definir que es una clave publica y que es una clave privada, para ello utilizaremos la siguiente imagen:
![cifrado](/img/clavesCifrado.png "cifrado")

Vamos a desglosar los elementos y el flujo:

* **Alice (izquierda):** Es el remitente del mensaje. Contiene un "Texto Plano".

* **Bob (derecha):** Es el receptor del mensaje.

**Llaves de Bob:**

* **Bob (pub): Llave publica de Bob:** Esta es una llave que Bob comparte libremente con cualquiera, no necesita ser secreta.

* **Bob (priv): Llave privada de Bob:** Esta llave es secreta y solo Bob la posee. Si alguien mas la obtiene podra tomar control total.

* **E (cuadro verde):** Representa el proceso de cifrado.
* **D (cuadro rojo):** Representa el proceso de descifrado.

* **Texto Cifrado:** Es el mensaje original (Texto Plano) que ha sido transformado para ser ilegible para cualquiera que no tenga la llave correcta.

**Flujo de Proceso:**

1. **Bob envia su llave publica (Bob (pub)) a Alice.** Esta llave puede ser distribuida libremente no hay ningun problema con compartirla ya que solo sirve para cifrar, no para descifrar.
2. **Alice toma el "Texto Plano" y utiliza la llave publica de Bob para cifrarlo.** El resultado es el "Texto Cifrado". En este punto solo la llave privada de Bob puede descifrar este mensaje. Nadie mas ni siquiera Alice, una vez cifrado puede leer el mensaje cifrado.
3. **Bob recibe el "Texto Cifrado" y utiliza su propia llave privada para descifrarlo.** Esto transforma el "Texto Cifrado" de nuevo en el "Texto Plano", que Bob puede leer.

En polkadot el algoritmo de hashing que se utiliza es [Blake2b](https://en.wikipedia.org/wiki/BLAKE_(hash_function)#BLAKE2) (al igual que [Zcash](https://z.cash/)) un algoritmo mas rapido que el algoritmo de cifrado de Bitcoin [SHA-256d](https://www.google.com/search?q=SHA-256d&ie=UTF-8) el cual es una doble aplicacion del algoritmo [SHA-256](https://www.google.com/search?q=SHA-256&ie=UTF-8) para incrementar la dificultad computacional para encontrar un hash especifico.

---
![Subkey](/img/subkey.jpg "Subkey")

## `Subkey` es una utilidad de linea de comandos esencial para la gestion de claves criptograficas y direcciones en cualquier cadena basada en Substrate (incluyendo Polkadot y tu parachain). Te permite generar, inspeccionar y derivar claves, asi como generar "vanity addresses" (direcciones con patrones personalizados).

---

## 1. Instalacion de `Subkey`

Para ello vamos a instalar `subkey` con el siguiente comando:

```bash
cargo install subkey --locked
```

## 2. Generando un nuevo par de claves (Wallet):
Este es el comando fundamental para crear una nueva wallet o par de claves criptograficas.

```bash
subkey generate
```
Este comando genera aleatoriamente una nueva frase semilla. A partir de esta frase semilla se deriva automaticamente tu clave publica en forma hexadecimal y SS58.

Ejemplo de salida:
```bash
Secret phrase:       judge shuffle deliver kit canal draw settle cigar noble true answer sketch
  Network ID:        substrate
  Secret seed:       0xbc946801656ff9ed9a9de0af17e31f5f8ca36b9dc6bfd71e41e691a767339c07
  Public key (hex):  0x4221c2fc06c6efd782c58bb43df2ba198ff269beb09169c78af2a195f59abf1f
  Account ID:        0x4221c2fc06c6efd782c58bb43df2ba198ff269beb09169c78af2a195f59abf1f
  Public key (SS58): 5DZR3ftGEz6jFUgEgrA44MDzrKKMZUAKHNFbEpZhe98GoREK
  SS58 Address:      5DZR3ftGEz6jFUgEgrA44MDzrKKMZUAKHNFbEpZhe98GoREK
  ```
  * `Secret phrase:` Es la representacion legible de tu clave privada, de ella se genera tanto la clave publica como la privada.
  * `Network ID:` Indica el formato de red por defecto para la direccion SS58 generada.
  * `Secret seed (Clave privada):` Es la clave privada en su formato raw hexadecimal. No es la semilla como tal, es el resultado de procesar la frase semilla para obtener la clave privada.
  * `Public key:` Esta es la clave publica de tu cuenta en su representacion hexadecimal la cual se genera a partir de la secret seed la cual puede ser usada en contratos inteligentes o llamadas a APIs que     requieran el identificador de la cuenta en formado hexadecimal.
  * `Account ID:` Es simplemente la clave publica en formato hexadecimal representada como un hash de 32 bytes que sirve para identificar tu cuenta.
  * `Public key (SS58):` Es la direccion de tu cuenta en el formato SS58 la cual podria utilizar cualquier persona para enviarte fondos de cualquier parachain basada en substrate.
  * `SS58 Address:` Es la misma que la clave publica SS58 y tiene el mismo uso.

## 3. Inspeccion de claves y direcciones:
  El comando `subkey instpect` te permite verificar la informacion de una clave o frase semilla.
  ```bash
   subkey inspect "frase semilla"
   subkey inspect "0x1a2b3c4d5e6f7a8b9c0d1e2f3a4b5c6d7e8f9a0b1c2d3e4f5a6b7c8d9e0f1a2b"
  ```
  Al añadir tu frase semilla `subkey` te mostrara la clave publica tanto en SS58 como en hexadecimal.
  Las redes basadas en substrate vienen con un conjunto de claves de desarrollo predefinidas como `//Alice, //Bob, //Charlie`.Estas son frases semillas que se utilizan para pruebas y desarrollo, al inspeccionar cualquiera de ellas podras ver su clave publica y la direccion asociada a dicha cuenta por ejemplo:
```bash
subkey inspect "//Alice"
Secret Key URI `//Alice` is account:
  Network ID:        substrate
  Secret seed:       0xe5be9a5092b81bca64be81d212e7f2f9eba183bb7a90954f7b76361f6edb5c0a
  Public key (hex):  0xd43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d
  Account ID:        0xd43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d
  Public key (SS58): 5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY
  SS58 Address:      5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY
```
## 4. "Vanity Addresses" direcciones con un Patron:
Una vanity address es una direccion que contiene un patron de caracteres esecifico como un nombre o una palabra personalizada, el proceso puede ser un poco tardado dependiendo de el numero de caracteres solicitado.
`subkey` puede generar estas direcciones para las redes Substrate. El proceso implica generar millones (o incluso billones) de pares de claves aleatorias hasta que uno de ellos resulte en una direccion SS58 que coincida con el patron que especificaste.

La generacion de vanity addresses es un proceso que consume muchos recursos.
* **Velocidad:**
    * **Muy rapido:** Para patrones muy cortos (2-3 caractere).
    * **Lento:** Para patrones de 4-5 caracteres (minutos, horas, dependiendo de tu CPU).
    * **Extremadamente lento o inviable:** Para patrones muy largos o complejos (dias, semanas, meses, o mas). Un caracter adicional en el patron aumenta exponencialmente el tiempo de busqueda.
* **Caracteres Validos:** Las direcciones SS58 utilizan un conjunto especifico de caracteres base58. Esto significa que no todos los caracteres son validos. Por ejemplo, no veras numeros `0` o `O` mayuscula (se confunden con la letra 'o'), o `I` mayuscula (se confunde con 'l' minuscula), o simbolos especiales. `subkey` lo maneja automaticamente.

---
###**Como funciona el parametro `--pattern` y las Expresiones Regulares (Regex)**

El parametro `--pattern` de `subkey vanity` utiliza **expresiones regulares (regex)** para definir el patron que buscas. Las expresiones regulares son una secuencia de caracteres que tienen su propia sintaxis.

Aqui estan los caracteres de regex mas comunes y utiles para `subkey vanity`:

* `^` **Por ejemplo:** `^ABC` buscara direcciones que **empiecen** con "ABC".
* `$` **Por ejemplo:** `XYZ$` buscara direcciones que **terminen** con "XYZ".
* `.` **Por ejemplo:** `A.C` buscara "AEC", "ABC", "AXC", etc.
* `*` **Por ejemplo:** `A*B` coincidira con "B", "AB", "AAB", "AAAB", etc.
* `.*`**Por ejemplo:** `^ABC.*XYZ$` buscara direcciones que empiecen con "ABC", tengan cualquier cosa en el medio, y terminen con "XYZ".
* `+` **Po ejemplo:** `A+B` coincidira con "AB", "AAB", "AAAB", pero NO con "B".
* `?` **Por ejemplo:** `AB?C` coincidira con "AC" o "ABC".
* `[...]`: cualquier cosa dentro de los corchetes.
    * **Ejemplo:** `[ABC]` coincidira con "A", "B", o "C".
    * **Ejemplo:** `[0-9]` coincidira con cualquier digito.
    * **Ejemplo:** `[A-Za-z]` coincidira con cualquier letra mayuscula o minuscula.
* `|` (Pipe):** Actua como un "OR" logico.
    * **Ejemplo:** `ABC|XYZ` buscara direcciones que contengan "ABC" **o** "XYZ".

---

### **Ejemplos de `Subkey vanity`**

Para cada ejemplo, `subkey` generara frases semilla y direcciones hasta que encuentre una que cumpla el patron. Una vez que encuentre una, la imprimira y se detendra.

**Buscar una direccion que empiece con "DEV"**
``
```bash
    subkey vanity --pattern DEV
    subkey vanity --pattern ".*(BTC|ETH).*"
```
**Buscar una direccion que contenga c "BTC"o "ETH"**
```bash
    subkey vanity --pattern ".*(BTC|ETH).*"
```

## 5. Firma de mensajes en cadena.
Ademas de gestionar claves subkey te permite firmar digitalmente mensajes con tu clave privada y verificar firmas con la clave publica de el firmante. Firmar mensajes es muy util ya que va mas alla de probar la propiedad de la cuenta si no que tambien sirve para:
* `Gobernanza y propuestas:` Un usuario con tokens puede votar en propuestas firmando un mensaje off-chain que declare su su intencion de voto algo como `("Vote 'yes' on proposal #123")`. Luego ese mensaje se envia a un servicio o relayer que agrupa varias firmas y envia una unica transaccion en cadena lo cual reduce la carga y las tarifas de la red.
* `Mensajes de autenticacion:`
Por ejemplo al utilizar una DApp o un servicio web necesita verificar que el usuario que esta conectando su wallet es el propietario de la direccion que esta tratando de conectar.La DApp le pide al usuario que firme un mensaje por ejemplo: una cadena de texto. El usuario firma este mensaje, la DApp luego recibe la firma y la clave publica del usuario, y confirma que la firma es valida para ese mensaje y esa clave publica. Esto permite autenticar a los usuarios sin necesidad de contraseñas tradicionales.
* `Comunicacion entre usuarios:`
Un usuario puede escribir un mensaje y firmarlo con su clave privada usando subkey. Luego envia el mensaje y la firma a otro usuario el cual puede verificar el mensaje como en el siguiente ejemplo:

 [![Firma](/img/firma.jpg)](https://x.com/0xNigromante/status/1917958529056391608)



Para firmar un mensaje necesitas tu frase semilla o tu URI como `//Alice` y el mensaje que quieres firmar. El mensaje se le pasara a `subkey sign` a traves de la entrada estandar(STDIN):
```bash
   echo "Hola 🌐" | subkey sign --suri 'judge shuffle deliver kit canal draw settle cigar noble true answer sketch'
```
O podemos usar el contenido de un archivo como por ejemplo:
```bash
   subkey sign --suri 'judge shuffle deliver kit canal draw settle cigar noble true answer sketch' < mensaje.txt
```
En la salida tendremos algo como esto:
```bash
  0xcca73456d13ef522edf33d11f813945c55f4a7446464eb146d41de5ac11836350d9771f225d4797d45b79403a0ad34749670b0864108dab83eb26519cfc5a48a
``` 

## 6. Verificar una Firma
Para verificar una firma, necesitaras el mensaje original, la firma generada, y la clave publica (o direccion SS58) del firmante. `subkey` te permite realizar esta verificacion facilmente.

**Sintaxis:**
```bash
# SINTAXIS: mensaje_original | subkey verify 'firma_hexadecimal' 'direccion_ss58_o_public_key_hex'         
echo "Hola 🌐" | subkey verify '0xcca73456d13ef522edf33d11f813945c55f4a7446464eb146d41de5ac11836350d9771f225d4797d45b79403a0ad34749670b0864108dab83eb26519cfc5a48a' '5DZR3ftGEz6jFUgEgrA44MDzrKKMZUAKHNFbEpZhe98GoREK'
```
O tambien:
```bash
cat mensaje.txt | subkey verify '0xcca73456d13ef522edf33d11f813945c55f4a7446464eb146d41de5ac11836350d9771f225d4797d45b79403a0ad34749670b0864108dab83eb26519cfc5a48a' '5DZR3ftGEz6jFUgEgrA44MDzrKKMZUAKHNFbEpZhe98GoREK'
```
Salida esperada:
```bash
Signature is valid
```
En caso de que la firma sea invalida veras algo como esto:
```bash
Error: SignatureInvalid
```
## 7. Derivacion de cuentas:
Ademas de generar claves aleatorias subkey te permite la derivacion de cuentas, es una funcionalidad que te permite crear mas pares de claves unicos a partir de una frase semilla.

### Tipos de derivacion:
 * Derivacion Hardened: Genera claves de forma que la clave privada hija no pueda ser derivada de la clave publica y la ruta de derivacion hardened, este tipo de derivacion es la mas comun ya que permite al usuario crear distintas billeteras con su respectiva clave privada cada una, todas esas cuenta son hijas de la misma frase semilla pero sus direcciones publicas no revelan parentescos entre si ni como se derivaron.

 * Derivacion soft: Las claves privadas hijas pueden ser derivadas de la clave publica padre, por lo cual si alguien obtiene la clave publica padre y la ruta de derivacion soft podria calcular la clave publica hija.
 esto la hace menos segura pero puede ser util en escenarios donde se necesita tener transparencia de derivacion como en los intercambios de criptomonedas o comercios que acepten cripto como metodo de pago, de esta forma puden crear una direccion unica para cada uno de sus clientes sin tener que gestionar una clave privada para cada una.


### Inspeccionemos nuestra frase semilla para ver las diferencias:
```bash
subkey inspect 'judge shuffle deliver kit canal draw settle cigar noble true answer sketch'
```

```bash
subkey inspect 'judge shuffle deliver kit canal draw settle cigar noble true answer sketch'
Secret phrase:       judge shuffle deliver kit canal draw settle cigar noble true answer sketch
  Network ID:        substrate
  Secret seed:       0xbc946801656ff9ed9a9de0af17e31f5f8ca36b9dc6bfd71e41e691a767339c07
  Public key (hex):  0x4221c2fc06c6efd782c58bb43df2ba198ff269beb09169c78af2a195f59abf1f
  Account ID:        0x4221c2fc06c6efd782c58bb43df2ba198ff269beb09169c78af2a195f59abf1f
  Public key (SS58): 5DZR3ftGEz6jFUgEgrA44MDzrKKMZUAKHNFbEpZhe98GoREK
  SS58 Address:      5DZR3ftGEz6jFUgEgrA44MDzrKKMZUAKHNFbEpZhe98GoREK
```
### Para realizar una derivacion hardened se utiliza `//` (doble barra) seguido de un nombre (`//nombre`): 
```bash
subkey inspect 'judge shuffle deliver kit canal draw settle cigar noble true answer sketch//wallet1'
```
### O podemos usar rutas numericas `/1'` seguido de un numero con apostrofe :
```bash
subkey inspect 'judge shuffle deliver kit canal draw settle cigar noble true answer sketch/1'''
```
##### Nota: El final es parte del argumento del shell para escapar el apostrofe de la ruta. Muchos shells requieren que el URI completo este entre comillas simples o dobles, por lo que `'ruta/1'''` o `"ruta/1'"` son formas de escapar el apostrofe que es parte de la ruta de derivacion.

### Ejemplo de salida:
```bash
Secret Key URI `judge shuffle deliver kit canal draw settle cigar noble true answer sketch//wallet1` is account:
  Network ID:        substrate
  Secret seed:       0x9eb666cfc03b2749cdb5127c1416c87a95134f88bd1efec8653ac51a34e3619b
  Public key (hex):  0xb677bc3c00a7e326b8401e480e990a727fb3d2f549760ae5ce88ddb66b12b84f
  Account ID:        0xb677bc3c00a7e326b8401e480e990a727fb3d2f549760ae5ce88ddb66b12b84f
  Public key (SS58): 5GBx98XzxyQttdJ1y8WdLxqCpXuDE8kR9tb3dNayPhHmjUuN
  SS58 Address:      5GBx98XzxyQttdJ1y8WdLxqCpXuDE8kR9tb3dNayPhHmjUuN
```
### Para realizar una derivacion soft se utiliza `/` (barra simple) seguido de un nombre (`/nombre`):
```bash
subkey inspect 'judge shuffle deliver kit canal draw settle cigar noble true answer sketch/polkadot'
```
### O podemos usar rutas numericas simples sin el apostrofe `/1`:
```bash
subkey inspect 'judge shuffle deliver kit canal draw settle cigar noble true answer sketch/2'
```

### Ejemplo de salida:
```bash
Secret Key URI `judge shuffle deliver kit canal draw settle cigar noble true answer sketch/polkadot` is account:
  Network ID:        substrate
  Secret seed:       n/a
  Public key (hex):  0x94cca23e7d6a1d3ad14f8471ab78218b1ecbc7349606cdf206fcdde6edffc80e
  Account ID:        0x94cca23e7d6a1d3ad14f8471ab78218b1ecbc7349606cdf206fcdde6edffc80e
  Public key (SS58): 5FRojU9AdQk23YzyFkbKDJbgyiL6GfPrPtp3zzmCxL4yLfQj
  SS58 Address:      5FRojU9AdQk23YzyFkbKDJbgyiL6GfPrPtp3zzmCxL4yLfQj
```
##### Nota: como puedes ver en Secreet seed no nos muestra nada y eso es debido a que al crear una ruta de derivacion soft con un nombre como `"/polkadot"` Substrate no simplemente suma un indice a la clave privada si no que utiliza un proceso donde involucra:
* La clave publica padre
* Un hash (generalmente Blake2) del nombre de la eruta de derivacion en este caso `"polkadot"`
* Una funcion criptografica para combinar estos elementos y derivar la clave publica hija en este caso: `"5FRojU9AdQk23YzyFkbKDJbgyiL6GfPrPtp3zzmCxL4yLfQj"`

👉[Capitulo 5](/recursos/cap_5(IPFS).md)
---


