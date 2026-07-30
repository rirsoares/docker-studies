# Módulo 2 — Exercícios

> Tente resolver sem consultar o gabarito.

## Parte A — Conceitos

1. Por que imagens são divididas em camadas? Cite dois benefícios.
2. Qual a diferença entre `RUN` e `CMD`? Use a analogia da fábrica/chave.
3. `EXPOSE 80` no Dockerfile faz a porta 80 ficar acessível no navegador? Justifique.
4. O que acontece com a camada de escrita de um container quando ele é removido?
5. Por que colocar o `COPY` do código DEPOIS da instalação de dependências acelera builds?

## Parte B — Prática

6. Construa e rode os dois exemplos da pasta `exemplos/` (site-estatico e app-python).
7. No exemplo do site, mude o texto do HTML, rebuilde como `meu-site:2.0` e rode as duas
   versões ao mesmo tempo em portas diferentes. O que isso mostra sobre tags?
8. Rode `docker history meu-site:2.0` e identifique a camada criada pelo seu `COPY`.
9. Rode o build do app-python duas vezes seguidas e compare os tempos. Explique a diferença.
10. Desafio: crie do zero uma imagem `relogio:1.0` baseada em `python:3.12-slim` cujo
    container imprima a data/hora atual a cada 2 segundos. Dica: módulo `datetime`.
