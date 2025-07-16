#!/bin/bash

set -e  # Salir si algún comando falla

# Colores
PURPLE='\033[1;35m'
CYAN='\033[1;36m'
GREEN='\033[1;32m'
NC='\033[0m' # No Color

# Spinner
spinner() {
  local pid=$!
  local icons=('⠋' '⠙' '⠹' '⠸' '⠼' '⠴' '⠦' '⠧' '⠇' '⠏')
  local i=0
  tput civis  # Oculta cursor
  while kill -0 $pid 2>/dev/null; do
    i=$(( (i+1) % ${#icons[@]} ))
    printf "\r${CYAN}${icons[$i]} $1...${NC}"
    sleep 0.1
  done
  wait $pid 2>/dev/null
  printf "\r${GREEN}✔ $1 completado.${NC}\n"
  tput cnorm  # Muestra cursor
}

# Ejecutar spinner
run_with_spinner() {
  bash -c "$1" & spinner "$2"
}

echo -e "${PURPLE}=== Instalando dependencias del sistema... ===${NC}"
run_with_spinner "sudo apt update" "Actualizando paquetes"
run_with_spinner "sudo apt install -y build-essential clang curl git make protobuf-compiler" "Instalando paquetes base"

echo -e "${PURPLE}=== Instalando Rust... ===${NC}"
run_with_spinner "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y" "Descargando Rust"
source $HOME/.cargo/env

echo -e "${PURPLE}=== Configurando Rust... ===${NC}"
RUST_VERSION="1.86.0"
run_with_spinner "rustup install $RUST_VERSION" "Instalando Rust $RUST_VERSION"
run_with_spinner "rustup default $RUST_VERSION" "Asignando versión por defecto"
run_with_spinner "rustup update" "Actualizando toolchain"
run_with_spinner "rustup target add wasm32-unknown-unknown --toolchain ${RUST_VERSION}-x86_64-unknown-linux-gnu" "Añadiendo target WASM"
run_with_spinner "rustup component add rust-src --toolchain ${RUST_VERSION}-x86_64-unknown-linux-gnu" "Añadiendo rust-src"

echo -e "${PURPLE}=== Instalando herramientas de Polkadot... ===${NC}"
run_with_spinner "cargo install --locked staging-chain-spec-builder@10.0.0" "Instalando chain-spec-builder"
run_with_spinner "cargo install --locked polkadot-omni-node@0.5.0" "Instalando polkadot-omni-node"

echo -e "${PURPLE}=== Clonando el template... ===${NC}"
if [ ! -d "parachain-template" ]; then
  run_with_spinner "git clone -b stable2412 https://github.com/paritytech/polkadot-sdk-parachain-template.git parachain-template" "Clonando repositorio"
fi
cd parachain-template

echo -e "${PURPLE}=== Compilando el nodo... Esto puede tardar varios minutos ... ===${NC}"
run_with_spinner "cargo build --release --locked" "Compilando el nodo"

echo -e "${PURPLE}=== Creando chain specs... ===${NC}"
run_with_spinner "chain-spec-builder create -t development --relay-chain paseo --para-id 1000 --runtime ./target/release/wbuild/parachain-template-runtime/parachain_template_runtime.compact.compressed.wasm named-preset development" "Creando chain specs"

echo -e "${PURPLE}=== Iniciando nodo... ===${NC}"
polkadot-omni-node --chain ./chain_spec.json --dev
