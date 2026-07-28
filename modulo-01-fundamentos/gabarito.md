# Módulo 1 — Gabarito comentado

## Parte A

**1.** A imagem é o pacote imutável (molde) com o programa e suas dependências; o container é
uma instância dessa imagem em execução. De uma imagem podem nascer vários containers.

**2.** Containers são mais leves (MBs vs GBs), iniciam em segundos, consomem menos memória e
permitem rodar muito mais instâncias no mesmo hardware, pois compartilham o SO do host em vez
de virtualizar um SO completo.

**3.** O Docker procura a imagem localmente; não encontrando, baixa automaticamente do Docker Hub
(`docker pull` implícito) e então cria e executa o container.

**4.** Falso. O container parado continua existindo (aparece em `docker ps -a`) e pode ser
reiniciado com `docker start`. Só é apagado com `docker rm` (ou se criado com a flag `--rm`).

## Parte B

**5.** `docker run hello-world` — a etapa de download aparece como
`Unable to find image 'hello-world:latest' locally` seguido de `Pulling from library/hello-world`.

**6.**
```bash
docker run -it ubuntu bash
cat /etc/os-release   # campo VERSION mostra, ex.: "24.04 LTS (Noble Numbat)"
exit
```

**7.**
```bash
docker run -d -p 9090:80 nginx
# navegador: http://localhost:9090
```

**8.**
```bash
docker ps                 # pega o ID ou nome
docker stop <id>
docker rm <id>
```

**9.**
```bash
docker images
docker rmi hello-world
# se der erro, remova antes o container parado: docker ps -a && docker rm <id>
```
Comentário: uma imagem não pode ser removida enquanto existir um container (mesmo parado) criado a partir dela.

**10.**
```bash
docker run -d -p 8080:80 nginx
docker run -d -p 8081:80 nginx
```
Demonstra que **uma mesma imagem gera vários containers independentes** — cada um com seu
próprio ciclo de vida, mapeado em portas diferentes do host.
