# ─── Stage 1: Build ───────────────────────
FROM denoland/deno:2.4.2 AS builder
WORKDIR /app

# Copy everything you need
COPY deno.json deno.lock server/ lib/ . 

# Build in server/
WORKDIR /app/server
RUN deno task build

# ─── Stage 2: Runtime ─────────────────────
FROM debian:12-slim
RUN useradd -ms /bin/bash deno
USER deno
WORKDIR /home/deno

RUN mkdir tmp
COPY --from=builder /app/server/build/server ./server

ENV SERVER_PORT=8080
EXPOSE 8080

CMD ["./server"]CMD ["./server"]