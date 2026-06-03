# --- ETAPA 1: Compilación ---
FROM golang:1.22-alpine AS builder

# Instalar dependencias necesarias para compilar (como gcc si usas drivers nativos)
RUN apk add --no-cache git gcc musl-dev

WORKDIR /app

# Copiar archivos de dependencias de Go
COPY go.mod go.sum ./
RUN go mod download

# Copiar el código fuente
COPY . .

# Compilar el binario optimizado y estático (más seguro y ligero)
RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-s -w" -o backend-api .

# --- ETAPA 2: Contenedor Final de Ejecución ---
FROM alpine:latest

RUN apk add --no-cache ca-certificates tzdata

WORKDIR /app

# Copiar solo el binario compilado desde la etapa anterior
COPY --from=builder /app/backend-api .

# Exponer el puerto en el que escucha tu API de Go
EXPOSE 8080

# Comando para ejecutar la aplicación
CMD ["./backend-api"]
