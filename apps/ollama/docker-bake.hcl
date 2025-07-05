variable "REGISTRY" {
  default = "ghcr.io"
}

variable "OWNER" {
  default = "neilmulder"
}

variable "VERSION" {
  default = "latest"
}

variable "CHANNEL" {
  default = "stable"
}

target "ollama" {
  context = "."
  dockerfile = "Dockerfile"
  tags = [
    "${REGISTRY}/${OWNER}/ollama:${VERSION}",
    "${REGISTRY}/${OWNER}/ollama:latest"
  ]
  platforms = ["linux/amd64", "linux/arm64"]
  
  args = {
    INTEL_COMPUTE_RUNTIME_VERSION = "24.35.30872.22"
  }
  
  labels = {
    "org.opencontainers.image.title" = "Ollama with Intel GPU Support"
    "org.opencontainers.image.description" = "Ollama with Intel GPU compute runtime libraries"
    "org.opencontainers.image.source" = "https://github.com/neilmulder/containers"
    "org.opencontainers.image.version" = "${VERSION}"
  }
}