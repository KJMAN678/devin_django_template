FROM python:3.13-slim-bookworm
COPY --from=ghcr.io/astral-sh/uv:0.9.13 /uv /bin/uv

# psycopg2 ビルドに必要なパッケージをインストール
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libpq-dev \
  && rm -rf /var/lib/apt/lists/*

# Sync the project into a new environment, using the frozen lockfile
WORKDIR /app
COPY . /app
RUN uv sync --dev
