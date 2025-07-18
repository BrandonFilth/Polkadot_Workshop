# 🔑 Ejemplos Prácticos de `subkey`: Gestión de Claves y Direcciones 🔑

`subkey` es una utilidad de línea de comandos esencial para la gestión de claves criptográficas y direcciones en cualquier cadena basada en Substrate (incluyendo Polkadot y tu parachain). Te permite generar, inspeccionar y derivar claves, así como generar "vanity addresses" (direcciones con patrones personalizados).

---

## 1. Instalación de `subkey`

Para ello vamos a instalar `subkey` con el siguiente comando:

```bash
cargo install subkey --locked
```

## Generando un nuevo par de claves (Wallet)
Este es el comando fundamental para crear una nueva "wallet" o par de claves criptográficas.

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
La frase semilla es una serie de 12 o 24 palabras que son la representacion legible de tu clave privada, quien tenga acceso a esta frase tendra control total sobre tu cuenta o subcuentas.
La clave publica SS58 es tu direccion de cuenta que compartes con otros al recibir fondos, el formato SS58 es una codificacion de la clave publica especifica para las redes basadas en substrate.
La clave publica hexadecimal es la representacion hexadecimal de tu clave publica