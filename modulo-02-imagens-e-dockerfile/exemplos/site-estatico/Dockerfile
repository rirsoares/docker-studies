# Parte da imagem oficial do nginx...
FROM nginx:alpine

# ...e substitui a página padrão pela nossa.
# /usr/share/nginx/html é a pasta que o nginx serve.
COPY index.html /usr/share/nginx/html/index.html

# O CMD já vem herdado da imagem do nginx — não precisamos redefinir.
