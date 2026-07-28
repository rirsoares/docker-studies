# Como publicar este repositório no GitHub

## Primeira vez (criar o repositório)

1. No [GitHub](https://github.com/new), crie um repositório chamado `docker-studies`
   (público ou privado). **Não** marque "Add a README" — já temos um.

2. No Git Bash, dentro da pasta do repositório (`cd /g/REPOS/docker-studies`):

```bash
git init
git add .
git commit -m "Módulo 1: fundamentos de Docker"
git branch -M main
git remote add origin https://github.com/rirsoares/docker-studies.git
git push -u origin main
```

## Atualizações futuras (a cada novo módulo)

```bash
git add .
git commit -m "Módulo 2: imagens e Dockerfile"
git push
```

## Dicas

- `git status` mostra o que mudou antes de commitar
- Se o push pedir senha, use um [Personal Access Token](https://github.com/settings/tokens)
  ou configure SSH — a senha da conta não funciona mais
- Commits pequenos e frequentes (um por módulo/tema) deixam o histórico organizado
