# Mistral Vibe Docker Container

This project provides a Docker container for running Mistral Vibe in an isolated environment, avoiding Python package conflicts on your host system.

## Purpose

- **Clean Development Environment**: Run Mistral Vibe without installing Python packages globally
- **Isolation**: Keep dependencies contained within Docker
- **Portability**: Consistent environment across different systems

## Usage

### Prerequisites

- Docker installed on your system
- Fish shell (for the provided wrapper script)

### Quick Start

1. Build the Docker image:
   ```bash
   docker build -t vibe .
   ```

2. Use the Fish wrapper (recommended):
   ```bash
   source vibe.fish
   vibe [your arguments]
   ```

   Or run directly:
   ```bash
   mkdir -p ~/.config/vibe
   docker run --rm -it \
       -u $(id -u):$(id -g) \
       -e TERM=$TERM \
       -e HOME=/home/vibe \
       -e VIBE_CONFIG_DIR=/home/vibe/.vibe \
       -v $(pwd):/app \
       -v ~/.config/vibe:/home/vibe/.vibe \
       -w /app \
       ghcr.io/sniner/mistral-vibe-docker:latest [your arguments]
   ```

### Configuration

**Important**: Mistral Vibe uses a **global configuration directory** at `~/.config/vibe` on your host system. This configuration is:

- **User-wide**: Shared across all projects
- **Persistent**: Mounted into the container at `/home/vibe/.vibe`
- **Created on first run**: The directory is created when you first run Mistral Vibe

To check your configuration:
```bash
ls -la ~/.config/vibe/
```

**Note**: There is no project-specific `.vibe/` directory - all configuration is stored globally.

## Docker Image

The container uses:
- Base image: `python:3.12-slim`
- Installs: `mistral-vibe` package + development tools
- Entrypoint: `vibe` command

### Development Tools Included

For better assistance capabilities, the image includes:
- **Git**: Version control
- **Rust toolchain**: For Rust development support
- **Python tools**: pytest, black, flake8, mypy
- **Build tools**: gcc, make, etc.

This allows for:
- Running tests
- Code formatting and linting
- Building Rust binaries
- Better Git integration

## GitHub Workflow

This repository includes a GitHub Actions workflow (to be added) that:
- Builds the Docker image on every push
- Pushes to GitHub Container Registry (GHCR)
- Tags with commit SHA for traceability

## License

This project is licensed under the BSD 2-Clause License. See the [LICENSE](LICENSE) file for details.
