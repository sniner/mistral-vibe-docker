FROM python:3.12-slim

# Install development tools for better assistance capabilities
RUN apt-get update && apt-get install -y \
    git \
    curl \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install Rust toolchain (for Rust development support)
RUN curl --proto '=https' --tlss1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# Install Python development tools
RUN pip install --no-cache-dir \
    mistral-vibe \
    pytest \
    black \
    flake8 \
    mypy

WORKDIR /app
ENTRYPOINT ["vibe"]

