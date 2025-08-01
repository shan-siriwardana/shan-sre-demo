# Stage 1: Build the server 
FROM denoland/deno:2.4.2 AS builder
WORKDIR /app

# Copy the backend code & its Deno config
COPY server/ ./server
COPY lib/    ./lib

WORKDIR /app/server

RUN deno task build

# Stage 2: Runtime image
FROM debian:12-slim
RUN useradd -ms /bin/bash deno
USER deno
WORKDIR /home/deno

RUN mkdir tmp
COPY --from=builder /app/server/build/server ./server

ENV SERVER_PORT=8080
EXPOSE 8080

CMD ["./server"]