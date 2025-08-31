
FROM ghcr.io/astral-sh/uv:python3.12-bookworm-slim

# Install sops alongside uv
RUN apt-get update && apt-get install -y \
    ca-certificates \
    gnupg \
    wget \
    && rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/getsops/sops/releases/latest/download/sops-x86_64 \
    && chmod +x sops-x86_64 \
    && mv sops-x86_64 /usr/local/bin/sops

# Make sops executable
RUN chmod +x /usr/local/bin/sops

WORKDIR /app
ENV UV_COMPILE_BYTECODE=1
ENV UV_LINK_MODE=copy
ENV UV_TOOL_BIN_DIR=/usr/local/bin

# Install dependencies with uv
RUN --mount=type=cache,target=/root/.cache/uv --mount=type=bind,source=uv.lock,target=uv.lock --mount=type=bind,source=pyproject.toml,target=pyproject.toml --mount=type=bind,source=uv.lock,target=uv.lock \
    --mount=type=bind,source=pyproject.toml,target=pyproject.toml \
    uv sync --locked --no-install-project --no-dev

# Add source code and install project
COPY . /app
RUN --mount=type=cache,target=/root/.cache/uv uv sync --locked --no-dev

# Set PATH for executables
ENV PATH="/app/.venv/bin:$PATH"

# Default entrypoint - can run either uv or sops
ENTRYPOINT ["/usr/local/bin/uv"]
