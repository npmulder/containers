# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a container image repository following the home-operations/containers pattern. It builds custom container images with specific configurations and dependencies. The repository focuses on creating semantically versioned, rootless, multi-architecture containers.

## Development Setup

### Prerequisites
- Docker with Buildx support
- Task (go-task/task) for build automation
- GitHub CLI (gh) for remote operations
- goss for container testing

### Environment Management
The repository uses mise for development environment management. Install tools with:
```bash
mise install
```

## Build System

### Local Development
Use Task for local building and testing:

```bash
# Build a specific app locally
task local-build-ollama

# Build with specific platform
task local-build-ollama PLATFORM=linux/amd64

# Build with specific version
task local-build-ollama VERSION=1.0.0
```

### Remote Building
Trigger GitHub Actions builds:

```bash
# Build via GitHub Actions
task remote-build-ollama

# Release build
task remote-build-ollama RELEASE=true
```

## Container Architecture

### Directory Structure
- `apps/` - Individual application containers
- `include/` - Shared build components
- `.github/workflows/` - CI/CD automation

### Application Structure
Each app in `apps/` contains:
- `Dockerfile` - Container build instructions
- `entrypoint.sh` - Container initialization script
- `docker-bake.hcl` - Build configuration
- `tests.yaml` - goss test specifications

### Container Principles
- Non-root user execution (following security best practices)
- Multi-architecture support (linux/amd64, linux/arm64)
- Minimal base images with only necessary dependencies
- Configuration volume at `/config`
- Proper signal handling and process management

## Applications

### Ollama
Custom Ollama container with Intel GPU support:
- Base: `ollama/ollama:latest`
- Intel Level Zero GPU runtime libraries
- Intel OpenCL ICD support
- Automatic GPU detection and configuration
- Environment variables for Intel GPU optimization

The Intel GPU libraries are baked into the image, eliminating the need for init containers in Kubernetes deployments.

## CI/CD Pipeline

### Workflows
- `app-builder.yaml` - Builds and tests container images
- `release.yaml` - Handles automated releases on main branch changes
- `vulnerability-scan.yaml` - Weekly security scanning with Trivy and Snyk

### Image Registry
Images are published to GitHub Container Registry:
- `ghcr.io/neilmulder/ollama:latest`
- `ghcr.io/neilmulder/ollama:sha-<commit>`

## Testing

Container tests use goss for validation:
- HTTP endpoint availability
- Process and port verification
- File system and library checks
- User and permission validation

Run tests locally after building:
```bash
goss run --format documentation ./apps/ollama/tests.yaml
```