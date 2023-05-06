#!/bin/bash

# Verifica se o nome da imagem foi informado
if [ -z "$1" ]; then
  echo "ERRO: É necessário informar o nome da imagem como argumento."
  echo "Exemplo: ./build.sh nome_da_imagem"
  exit 1
fi

# Atribui o nome da imagem a uma variável
NOME_IMAGEM="$1"

sudo docker build -t builder__"$NOME_IMAGEM" -f ./builder/dockerfile .

sudo docker run -d builder__"$NOME_IMAGEM"

sudo mkdir ./dist

sudo docker cp $(sudo docker ps --format '{{.ID}}' --filter "ancestor=builder__"$NOME_IMAGEM""):/app ./dist

sudo docker rm -fv $(sudo docker ps --format '{{.ID}}' --filter "ancestor=builder__"$NOME_IMAGEM"")

sudo docker rmi builder__"$NOME_IMAGEM"

sudo docker build -t "$NOME_IMAGEM" -f ./runner/dockerfile .

sudo rm -r ./dist