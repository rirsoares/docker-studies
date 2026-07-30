# Módulo 2 — Gabarito comentado

## Parte A

**1.** Reaproveitamento (camadas comuns são baixadas/armazenadas uma vez só, economizando
disco e banda) e cache de build (só camadas alteradas são reconstruídas). Bônus: imutabilidade —
camadas somente leitura garantem que a imagem não é alterada pelo uso.

**2.** `RUN` executa durante o **build** e grava o resultado numa camada da imagem (o que a
fábrica faz ao montar o carro). `CMD` não executa no build; define o processo principal que
rodará quando o container **iniciar** (o que acontece ao girar a chave).

**3.** Não. `EXPOSE` é apenas **documentação** de qual porta o app usa. Quem efetivamente
publica a porta no host é a flag `-p 8080:80` no `docker run`.

**4.** É **descartada**. Tudo que o container escreveu fora de um volume se perde — as camadas
da imagem permanecem intactas. (Esse é o gancho para o Módulo 3: volumes.)

**5.** O cache invalida da primeira camada alterada **para baixo**. Código muda toda hora;
dependências, raramente. Com o código por último, uma mudança nele refaz só a camada final,
reaproveitando a instalação de dependências do cache.

## Parte B

**6.** Ver READMEs em `exemplos/`. Confirme com `docker ps` e `docker images`.

**7.**
```bash
docker build -t meu-site:2.0 .
docker run -d -p 8081:80 --name site-v1 meu-site:1.0
docker run -d -p 8082:80 --name site-v2 meu-site:2.0
```
Mostra que tags são **versões independentes** da mesma imagem: as duas coexistem, permitindo
rollback instantâneo — na prática é assim que se versiona software em produção.

**8.**
```bash
docker history meu-site:2.0
```
A camada do `COPY index.html ...` aparece no topo (camadas mais recentes primeiro), com o
tamanho minúsculo do HTML. As camadas de baixo são herdadas do `nginx:alpine`.

**9.** O primeiro build executa cada instrução; o segundo mostra `CACHED` em todos os passos
e termina quase instantaneamente, pois nada mudou — todas as camadas vieram do cache.

**10.** `relogio/app.py`:
```python
import time
from datetime import datetime

while True:
    print(datetime.now().strftime("%d/%m/%Y %H:%M:%S"), flush=True)
    time.sleep(2)
```
`relogio/Dockerfile`:
```dockerfile
FROM python:3.12-slim
WORKDIR /app
COPY app.py .
CMD ["python", "app.py"]
```
```bash
docker build -t relogio:1.0 .
docker run -d --name relogio relogio:1.0
docker logs -f relogio
```
