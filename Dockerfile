# Etapa 1: Construcción
FROM node:22-alpine AS builder
WORKDIR /app

# Copiar archivos de configuración
COPY package*.json ./
RUN npm ci

# Copiar el resto del código y construir
COPY . .
RUN npm run build

# Etapa 2: Servidor
FROM nginx:stable-alpine
# Copiar los archivos resultantes (Vite genera en /dist)
COPY --from=builder /app/dist /usr/share/nginx/html
EXPOSE 80
