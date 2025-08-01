# --- Stage 1: Build ---
FROM denoland/deno:1.44.4 AS builder

WORKDIR /app

COPY . .

# Build the app
RUN deno task build


# --- Stage 2: Runtime ---
FROM debian:12-slim

RUN useradd -ms /bin/bash deno
USER deno
WORKDIR /home/deno


# SQLite
RUN mkdir /home/deno/tmp

COPY --from=builder /app/build/server ./server

# used by the application
ENV SERVER_PORT=8080
EXPOSE 8080

# The command to run when the container starts.
CMD ["./server"]
