FROM ghcr.io/astral-sh/uv:python3.12-bookworm-slim

ARG SOPS_VERSION=v3.10.2

RUN apt-get update \
    && apt-get install -y age ca-certificates wget \
    && wget https://github.com/getsops/sops/releases/download/${SOPS_VERSION}/sops-${SOPS_VERSION}.linux.amd64 -O /usr/local/bin/sops \
    && chmod +x /usr/local/bin/sops \
    && rm -rf /var/lib/apt/lists/* \
    && command -v age >/dev/null \
    && echo "'age' installed successfully" \
    && command -v sops >/dev/null \
    && echo "'sops' installed successfully" \
    && command -v uv >/dev/null \
    && echo "'uv' installed successfully"
