# Exemplo 2 — App Python

```bash
docker build -t meu-app:1.0 .
docker run -d --name app meu-app:1.0
docker logs -f app        # acompanha a saída ao vivo (Ctrl+C para sair do logs)
docker stop app
```

Perguntas para refletir:
1. Por que esse container fica "Up" para sempre, ao contrário do hello-world?
2. Mude o texto do print, rebuilde com a mesma tag e rode de novo. Quais camadas foram refeitas?
