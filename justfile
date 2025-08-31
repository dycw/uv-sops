set dotenv-load := true
set positional-arguments := true

@build:
  docker build . -t ghcr.io/dycw/uv-sops:latest
