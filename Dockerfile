FROM python:3.13-slim-bookworm
COPY --from=ghcr.io/astral-sh/uv:0.9.21 /uv /bin/uv

WORKDIR /app
COPY . /app

# psycopg2 ビルドに必要なパッケージをインストール
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential=12.9 \
    libpq-dev=15.14-0+deb12u1 \
    postgresql-client=15+248+deb12u1 \
    && uv sync --dev \
    && apt-get purge -y build-essential libpq-dev \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*
