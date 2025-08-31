set dotenv-load := true
set positional-arguments := true

@build:
  docker build . -t ghcr.io/dycw/uv-sops:latest

@push:
  docker push ghcr.io/dycw/uv-sops:latest

@run:
  docker run ghcr.io/dycw/uv-sops:latest
