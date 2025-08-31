
FROM ghcr.io/astral-sh/uv:python3.12-bookworm-slim

COPY --from=getsops/sops:latest /usr/local/bin/sops /usr/local/bin/sops

ENTRYPOINT ["/usr/local/bin/uv"]
