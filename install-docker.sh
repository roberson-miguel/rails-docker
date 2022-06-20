#!/bin/bash

remove=$(sudo apt-get remove docker docker-engine docker.io containerd runc > /dev/null)

atualiza=$(sudo apt-get update > /dev/null)

certificado=$(sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release > /dev/null)

cria_diretorio=$(sudo mkdir -p /etc/apt/keyrings > /dev/null)
adiciona_chaves=$(curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
    sudo gpg --batch --yes --dearmor -o /etc/apt/keyrings/docker.gpg > /dev/null)

executa_instalacao=$(sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin > /dev/null)

permissao=$(sudo chmod a+r /etc/apt/keyrings/docker.gpg)

executa_imagem=$(sudo docker run hello-world)

echo "Removendo o Docker...\n"
echo $remove

echo "Atualizando pacotes...\n"
echo $atualiza

echo "Instalando certificados...\n"
echo $certificado

echo "Criando diretorio...\n"
echo $cria_diretorio

echo "Adicionando chaves...\n"
echo $adiciona_chaves

echo "Configurando repositorio...\n"
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable \n" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "\nAtualizando pacotes...\n"
echo $atualiza

echo "Habilita permissões...\n"
echo $permissao

echo "Executando instalação Docker e dependencias...\n"
echo $executa_instalacao

echo "Executando imagem.....Se voce ver log abaixo escrito: 'Hello from docker' sua instalação está ok! \n \n"
echo $executa_imagem
