FROM python:3.12-slim

# Install development tools including Rust via apt
RUN apt-get update && apt-get install -y \
    git \
    curl \
    build-essential \
    rustc \
    cargo \
    && rm -rf /var/lib/apt/lists/*

# Install Python development tools
RUN pip install --no-cache-dir \
    mistral-vibe \
    pytest \
    black \
    flake8 \
    mypy

WORKDIR /app
ENTRYPOINT ["vibe"]

