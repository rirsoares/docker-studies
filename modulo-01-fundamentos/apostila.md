# Módulo 1 — Fundamentos de Docker

> **Objetivo:** ao final deste módulo você saberá explicar o que é Docker, por que ele existe,
> e conseguirá rodar seus primeiros containers.

## 1. O problema que o Docker resolve

Imagine esta cena clássica: um desenvolvedor cria um programa no computador dele e funciona
perfeitamente. Ele manda para o colega... e não funciona. "Na minha máquina funciona!" 🤷

Por quê? Porque o programa depende de coisas instaladas na máquina: a versão certa do Python,
bibliotecas específicas, configurações do sistema. Cada computador é diferente.

**Docker resolve isso empacotando o programa junto com TUDO que ele precisa para rodar.**
Esse pacote se chama **container**. Ele roda igual em qualquer computador que tenha Docker.

### Analogia: o container de navio 🚢

Antes dos containers marítimos, cada carga (sacos de café, móveis, carros) era carregada de
um jeito diferente. Os containers padronizaram o transporte: não importa o que tem dentro,
todo navio, trem e caminhão sabe transportá-lo.

Docker faz o mesmo com software: não importa se é Python, Node ou Java —
todo servidor com Docker sabe executar o container.

## 2. Conceitos essenciais

| Conceito | O que é | Analogia |
|----------|---------|----------|
| **Imagem** | O "molde": pacote com o programa e suas dependências, somente leitura | Receita de bolo / planta da casa |
| **Container** | Uma instância em execução de uma imagem | Bolo pronto / casa construída |
| **Docker Hub** | Repositório público de imagens prontas | Loja de aplicativos |
| **Docker Engine** | O programa que roda os containers na sua máquina | O "motor" |

**Ponto-chave:** de UMA imagem você pode criar VÁRIOS containers, assim como uma receita gera vários bolos.

## 3. Container vs Máquina Virtual

Uma dúvida comum: "isso não é uma máquina virtual (VM)?"

- **VM:** simula um computador inteiro, com sistema operacional próprio. Pesada (GBs), demora minutos para ligar.
- **Container:** compartilha o sistema operacional do hospedeiro, isolando apenas o processo. Leve (MBs), liga em segundos.

```
   VM                          Container
┌───────────┐              ┌───────────┐
│  App      │              │  App      │
│  Bibliot. │              │  Bibliot. │
│  SO COMPLETO │           ├───────────┤
├───────────┤              │ Docker    │
│ Hypervisor│              ├───────────┤
├───────────┤              │ SO do host│
│ SO do host│              └───────────┘
└───────────┘
```

Por isso um servidor que rodaria ~5 VMs consegue rodar dezenas ou centenas de containers.

## 4. Instalando o Docker

- **Windows / macOS:** instale o [Docker Desktop](https://www.docker.com/products/docker-desktop/).
  No Windows ele usa o WSL2 (o instalador configura para você).
- **Linux:** instale o Docker Engine seguindo a [documentação oficial](https://docs.docker.com/engine/install/).

Para verificar a instalação, abra o terminal e rode:

```bash
docker --version
```

Se aparecer algo como `Docker version 27.x.x`, está pronto!

## 5. Primeiros comandos

### 5.1 O tradicional "hello world"

```bash
docker run hello-world
```

O que aconteceu aqui? O Docker:

1. Procurou a imagem `hello-world` na sua máquina → não achou
2. Baixou a imagem do Docker Hub (`Pulling from library/hello-world`)
3. Criou um container a partir dela
4. Executou o programa (que imprime a mensagem) e encerrou

### 5.2 Rodando algo mais interessante

```bash
docker run -it ubuntu bash
```

Você acabou de entrar num terminal Ubuntu dentro de um container! Explique as flags:

- `-i` (interactive): mantém a entrada aberta para você digitar
- `-t` (tty): aloca um terminal

Experimente `ls`, `cat /etc/os-release`. Digite `exit` para sair — o container para.

### 5.3 Um servidor web em 1 comando

```bash
docker run -d -p 8080:80 nginx
```

Abra http://localhost:8080 no navegador: um servidor web nginx está rodando!

- `-d` (detached): roda em segundo plano
- `-p 8080:80`: mapeia a porta 8080 do seu computador para a porta 80 do container

### 5.4 Gerenciando containers

```bash
docker ps              # lista containers em execução
docker ps -a           # lista todos (inclusive parados)
docker stop <id|nome>  # para um container
docker start <id|nome> # inicia um container parado
docker rm <id|nome>    # remove um container
docker images          # lista imagens baixadas
docker rmi <imagem>    # remove uma imagem
docker logs <id|nome>  # mostra a saída do container
```

> 💡 Você pode usar só os primeiros caracteres do ID: `docker stop a1b` funciona se for único.

## 6. Ciclo de vida de um container

```
docker run ──► Em execução ──► docker stop ──► Parado ──► docker rm ──► Removido
                    ▲                             │
                    └────────── docker start ─────┘
```

## 7. Resumo do módulo

- Docker empacota programas com suas dependências em **containers**
- **Imagem** é o molde; **container** é a instância em execução
- Containers são mais leves que VMs porque compartilham o SO do host
- `docker run` baixa (se preciso) e executa; `ps`, `stop`, `rm` gerenciam o ciclo de vida
- `-p` expõe portas; `-d` roda em segundo plano; `-it` abre modo interativo

**Próximo módulo:** criar suas próprias imagens com Dockerfile.
