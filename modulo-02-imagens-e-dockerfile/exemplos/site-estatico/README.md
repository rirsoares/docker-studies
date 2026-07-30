# Exemplo 1 — Site estático

```bash
docker build -t meu-site:1.0 .
docker run -d -p 8081:80 --name site meu-site:1.0
# abra http://localhost:8081
```

Repare: a imagem herda tudo do nginx (inclusive o CMD) e só adiciona uma camada com o HTML.
