FROM python:3.12-slim-bookworm

# sops - https://github.com/getsops/sops/blob/1c1b3c8787a9837bdeab616903e44666bae404d3/.release/Dockerfile
COPY --from=ghcr.io/getsops/sops:latest /usr/local/bin/sops /usr/local/bin/sops


# uv - https://github.com/astral-sh/uv/blob/9be016f3f8fdc3ac7974ed82762aa3364f6e8f2b/.github/workflows/build-docker.yml
COPY --from=docker.io/astral/uv:latest /uv /uvx /bin/echo

# RUN apt-get update \
#     # age
#     && apt-get install -y age \
#     && command -v age >/dev/null \
#     && echo "'age' installed successfully" \
#     # sops
#     && apt-get install -y age ca-certificates wget \
#     && wget https://github.com/getsops/sops/releases/download/${SOPS_VERSION}/sops-${SOPS_VERSION}.linux.amd64 -O /usr/local/bin/sops \
#     && chmod +x /usr/local/bin/sops \
#     && command -v sops >/dev/null \
#     && echo "'sops' installed successfully" \
#     # uv
#     && command -v uv >/dev/null \
#     && echo "'uv' installed successfully"  \
#     # clean up
#     && rm -rf /var/lib/apt/lists/*
RUN echo 'checking binaries...' \
    # age
    && command -v age >/dev/null \
    && echo "'age' installed successfully" \
    # sops
    && command -v sops >/dev/null \
    && echo "'sops' installed successfully" \
    # uv
    && command -v uv >/dev/null \
    && echo "'uv' installed successfully"

CMD ["/bin/sh"]
