#!/bin/bash
# Roteiro de demonstração ao vivo — Módulo 1
# Execute comando a comando durante a aula (não rode o script de uma vez)

# 1. Verificar instalação
docker --version

# 2. Primeiro container
docker run hello-world

# 3. Terminal Linux dentro de um container
docker run -it ubuntu bash
# dentro do container: ls, cat /etc/os-release, exit

# 4. Servidor web em segundo plano
docker run -d -p 8080:80 --name meu-nginx nginx
# abrir http://localhost:8080

# 5. Gerenciamento
docker ps
docker logs meu-nginx
docker stop meu-nginx
docker ps -a
docker start meu-nginx
docker stop meu-nginx
docker rm meu-nginx

# 6. Imagens
docker images
docker rmi hello-world
