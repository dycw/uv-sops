# base image
FROM python:3.12-slim-bookworm AS base

# sops
#  - ghcr   | https://github.com/getsops/sops/pkgs/container/sops/versions
#  - source | https://github.com/getsops/sops/blob/1c1b3c8787a9837bdeab616903e44666bae404d3/.release/Dockerfile
FROM ghcr.io/getsops/sops:v3.10.2 AS sops

# uv
#  - docker hub | https://hub.docker.com/r/astral/uv
#  - ghcr       | https://github.com/astral-sh/uv/pkgs/container/uv/versions
#  - source     | https://github.com/astral-sh/uv/blob/9be016f3f8fdc3ac7974ed82762aa3364f6e8f2b/.github/workflows/build-docker.yml
FROM ghcr.io/astral-sh/uv:0.8-python3.12-bookworm-slim AS uv

# final image
FROM base

# sops
COPY --from=sops /usr/local/bin/sops /usr/local/bin/sops

# uv
COPY --from=uv /uv /uvx /bin/echo

# test
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
