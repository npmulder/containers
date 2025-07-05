# 🐳 Custom Containers

> **Supercharged container images for modern infrastructure**

A curated collection of container images built with security, performance, and simplicity in mind. Each image is crafted to solve real-world deployment challenges while maintaining the highest standards of container best practices.

## 🚀 Features

- **🔒 Security First**: Non-root execution, minimal attack surface, regular vulnerability scanning
- **🏗️ Multi-Architecture**: Native support for AMD64 and ARM64 platforms
- **⚡ Performance Optimized**: Specialized builds with hardware acceleration support
- **🤖 Automated**: CI/CD pipeline with automated testing and releases
- **📦 Semantic Versioning**: Predictable releases with proper version management

## 🎯 Available Images

### Ollama with Intel GPU Support
Transform your AI workloads with hardware acceleration out of the box.

```bash
docker run -d \
  --name ollama \
  --device /dev/dri \
  -p 11434:11434 \
  -v ollama:/home/ollama/.ollama \
  ghcr.io/neilmulder/ollama:latest
```

**What makes it special:**
- 🎮 Intel GPU support with Level Zero and OpenCL
- 🔧 Pre-installed Intel compute runtime libraries
- 🚫 No init containers required in Kubernetes
- 🔍 Built-in GPU detection and diagnostics

## 🛠️ Quick Start

### Prerequisites
```bash
# Install development tools
mise install

# Or manually install:
# - Docker with Buildx
# - Task (go-task/task)
# - GitHub CLI
# - goss
```

### Build Locally
```bash
# Build any application
task local-build-ollama

# Test the build
task local-build-ollama PLATFORM=linux/amd64
```

### Deploy to Kubernetes
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: ollama
spec:
  template:
    spec:
      containers:
      - name: ollama
        image: ghcr.io/npmulder/ollama:latest
        resources:
          limits:
            gpu.intel.com/i915: 1
```

## 🏗️ Architecture

Built on proven patterns from the home-operations community:

```
containers/
├── apps/              # Individual applications
│   └── ollama/        # Ollama with Intel GPU
├── include/           # Shared build components
└── .github/workflows/ # Automated CI/CD
```

Each application follows a consistent structure:
- `Dockerfile` - Multi-stage, security-focused builds
- `entrypoint.sh` - Smart initialization and health checks
- `tests.yaml` - Comprehensive validation with goss
- `docker-bake.hcl` - Advanced build configuration

## 🔬 Quality Assurance

Every image undergoes rigorous testing:

- **🧪 Functional Testing**: HTTP endpoints, process validation, file system checks
- **🛡️ Security Scanning**: Weekly vulnerability assessments with Trivy and Snyk
- **📊 Performance Testing**: Resource usage and startup time validation
- **🔄 Integration Testing**: End-to-end deployment scenarios

## 🚢 Registry

Images are published to GitHub Container Registry with multiple tagging strategies:

- `ghcr.io/npmulder/ollama:latest` - Latest stable release
- `ghcr.io/npmulder/ollama:sha-abc123` - Specific commit builds
- `ghcr.io/npmulder/ollama:v1.0.0` - Semantic version tags

## 🤝 Contributing

We welcome contributions! Whether it's:

- 🐛 Bug fixes and improvements
- 📦 New application requests
- 📚 Documentation enhancements
- 🔧 Build system optimizations

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Inspired by the [home-operations/containers](https://github.com/home-operations/containers) project
- Built with ❤️ for the open-source community
- Special thanks to the Intel GPU compute runtime team

---

<div align="center">
<strong>🐳 Built for the cloud, optimized for performance, secured by design</strong>
</div>