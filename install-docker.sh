#!/usr/bin/env bash

#Salve esse conteudo em um arquivo com o nome "install-docker.sh" ou outro de sua preferencia, e execute em um terminal
#usando "sh install-docker.sh"

executa_imagem=$()

echo "Removendo versões antigas do Docker...\n"
sudo apt-get remove -y docker docker-engine docker.io containerd runc > /dev/null

echo "Atualizando pacotes...\n"
sudo apt-get update > /dev/null

echo "Instalando certificados...\n"
sudo apt-get install ca-certificates curl gnupg lsb-release > /dev/null

echo "Adicionando chaves...\n"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.gpg --create-dirs | sudo gpg --batch --yes --dearmor -o /etc/apt/keyrings/docker.gpg > /dev/null

echo "Configurando repositorio...\n"
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable \n" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "\nAtualizando sistema após instalação...\n"
sudo apt-get update > /dev/null

echo "Definido permissões no arquivo de definições para instalação do Docker...\n"
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo "Executando instalação Docker e dependencias...\n"
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin > /dev/null

echo "Executando imagem... Se voce ver log abaixo escrito: 'Hello from docker' sua instalação está ok! \n"
sudo docker run hello-world
