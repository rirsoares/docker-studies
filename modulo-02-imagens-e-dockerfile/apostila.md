# Módulo 2 — Imagens e Dockerfile

> **Objetivo:** entender o que uma imagem é por dentro (camadas), e criar suas próprias
> imagens com Dockerfile — o passo que transforma você de usuário em construtor.

## 1. O porquê deste módulo

No Módulo 1 você só usou imagens prontas de outras pessoas (`hello-world`, `ubuntu`, `nginx`).
Mas e quando o software é **seu**? Um script, uma aplicação, um serviço que você configurou?

É aqui que o Docker mostra seu real valor: você **empacota o seu software numa imagem própria**,
e ela roda idêntica em qualquer lugar — no seu PC, no servidor do cliente, na nuvem.

## 2. O que é uma imagem por dentro: camadas

Uma imagem **não é um arquivo único** — é uma pilha de **camadas (layers)** empilhadas,
cada uma contendo apenas a diferença em relação à anterior. Algo como:

```
┌─────────────────────────────┐
│ Camada 4: seu app copiado   │  ← só o que mudou
├─────────────────────────────┤
│ Camada 3: dependências      │
├─────────────────────────────┤
│ Camada 2: python instalado  │
├─────────────────────────────┤
│ Camada 1: base debian       │
└─────────────────────────────┘
```

**Por que assim?** Três motivos:

1. **Reaproveitamento:** se 10 imagens usam a mesma base debian, essa camada é baixada e
   armazenada UMA vez. Lembre do `docker run hello-world`: as linhas `Pull complete`
   apareciam separadas — cada uma era uma camada.
2. **Cache de build:** se você mudou só o seu código, o Docker reconstrói só a camada do
   código e reaproveita as demais. Builds ficam rápidos.
3. **Imutabilidade:** camadas são somente leitura. Quando um container roda, o Docker
   adiciona uma fina camada de escrita por cima. Ao remover o container, ela é descartada —
   por isso a imagem nunca é "suja" pelo uso.

## 3. Dockerfile: a receita da imagem

O `Dockerfile` é um arquivo de texto com instruções que o Docker executa, de cima para
baixo, para montar a imagem. **Cada instrução gera uma camada.**

Um exemplo mínimo e completo:

```dockerfile
# Camada base: começa de uma imagem existente
FROM python:3.12-slim

# Define o diretório de trabalho dentro da imagem
WORKDIR /app

# Copia arquivos do seu computador para dentro da imagem
COPY app.py .

# Comando executado QUANDO O CONTAINER INICIAR (não durante o build!)
CMD ["python", "app.py"]
```

### As instruções essenciais

| Instrução | Quando executa | O que faz |
|-----------|---------------|-----------|
| `FROM`    | build | Define a imagem base (toda imagem parte de outra) |
| `WORKDIR` | build | Define a pasta de trabalho (cria se não existir) |
| `COPY`    | build | Copia arquivos do host para a imagem |
| `RUN`     | **build** | Executa um comando e grava o resultado numa camada (ex.: instalar pacotes) |
| `ENV`     | build | Define variáveis de ambiente |
| `EXPOSE`  | build | **Documenta** a porta que o app usa (não publica! quem publica é o `-p`) |
| `CMD`     | **início do container** | Define o processo principal (lembre: o container vive enquanto ele viver) |

### RUN vs CMD — a confusão clássica

- `RUN apt-get install curl` → executa **durante o build**, o resultado fica gravado na imagem
- `CMD ["python", "app.py"]` → **não executa no build**; fica registrado como "o que rodar
  quando o container iniciar"

Analogia: `RUN` é o que a fábrica faz ao montar o carro; `CMD` é o que acontece quando você
gira a chave.

## 4. Construindo: docker build

```bash
docker build -t meu-app:1.0 .
```

Dissecando:

- `-t meu-app:1.0` — dá um **nome:tag** à imagem. A tag versiona (sem ela, vira `latest`)
- `.` — o **contexto de build**: a pasta cujos arquivos ficam disponíveis para o `COPY`.
  O Dockerfile é procurado aí dentro

Depois é o fluxo que você já conhece:

```bash
docker images            # sua imagem está na lista
docker run meu-app:1.0   # cria um container a partir DELA
```

### O cache em ação

Rode o mesmo build duas vezes: a segunda termina em instantes, com `CACHED` em cada passo.
Mude uma linha do `app.py` e rode de novo: só as camadas do `COPY` em diante são refeitas.

**Regra prática que nasce daí:** ordene o Dockerfile do que **menos muda** (base, dependências)
para o que **mais muda** (seu código). Assim o cache trabalha a seu favor.

## 5. .dockerignore

Irmão do `.gitignore`: lista o que **não** deve ser enviado no contexto de build
(ex.: `.git/`, `node_modules/`, arquivos de senha). Contexto menor = build mais rápido e
imagem sem lixo ou segredos.

```
.git
*.md
senhas.txt
```

## 6. De onde vêm e para onde vão as imagens

- `docker pull nginx` — baixa sem executar
- `docker push seu-usuario/meu-app:1.0` — publica no Docker Hub (requer conta e `docker login`)
- `docker tag meu-app:1.0 seu-usuario/meu-app:1.0` — renomeia/marca para publicação
- `docker history meu-app:1.0` — mostra as camadas e o comando que gerou cada uma
- `docker image prune` — remove imagens órfãs e libera espaço

## 7. Resumo do módulo

- Imagem = pilha de camadas somente leitura; container adiciona uma camada de escrita descartável
- Dockerfile é a receita; cada instrução gera uma camada
- `RUN` executa no build (fábrica); `CMD` define o processo principal do container (girar a chave)
- `EXPOSE` documenta, `-p` publica
- `docker build -t nome:tag .` constrói; ordene o Dockerfile do estável para o volátil por causa do cache
- `.dockerignore` mantém o contexto limpo

**Próximo módulo:** volumes — como dados sobrevivem à morte de um container.
