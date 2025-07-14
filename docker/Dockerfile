# FILE: renato-dev-setup/docker/Dockerfile

# Use uma imagem base com Node.js (ex: para fullstack JS)
FROM node:18-alpine

# Definir o diretório de trabalho dentro do container
WORKDIR /app

# Copiar os arquivos package.json e package-lock.json (ou yarn.lock) primeiro
# para aproveitar o cache do Docker layer
COPY package*.json ./

# Instalar as dependências do Node.js
RUN npm install

# Copiar o restante da aplicação
COPY . .

# Expor a porta que a aplicação vai usar (ex: para uma API REST ou app web)
EXPOSE 3000

# Comando para iniciar a aplicação quando o container for executado
CMD [ "npm", "start" ]

# Exemplo para Python/Flask (descomente e adapte se for seu caso)
# FROM python:3.9-slim-buster
# WORKDIR /app
# COPY requirements.txt ./
# RUN pip install --no-cache-dir -r requirements.txt
# COPY . .
# EXPOSE 5000
# CMD ["python", "app.py"]