FROM ollama/ollama:latest

USER root

# Install dependencies for Intel GPU support
RUN apt-get update && apt-get install -y \
    wget \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# renovate: datasource=github-releases depName=intel/compute-runtime
ARG INTEL_COMPUTE_RUNTIME_VERSION=24.35.30872.22

# Download and install Intel GPU compute runtime libraries (amd64 only)
RUN if [ "$(uname -m)" = "x86_64" ]; then \
        cd /tmp && \
        # Download all required Intel GPU packages including dependencies
        wget -q "https://github.com/intel/intel-graphics-compiler/releases/download/igc-1.0.17791.9/intel-igc-core_1.0.17791.9_amd64.deb" && \
        wget -q "https://github.com/intel/intel-graphics-compiler/releases/download/igc-1.0.17791.9/intel-igc-opencl_1.0.17791.9_amd64.deb" && \
        wget -q "https://github.com/intel/compute-runtime/releases/download/${INTEL_COMPUTE_RUNTIME_VERSION}/intel-gmmlib_22.5.2_amd64.deb" && \
        wget -q "https://github.com/intel/compute-runtime/releases/download/${INTEL_COMPUTE_RUNTIME_VERSION}/intel-level-zero-gpu_1.3.30872.22_amd64.deb" && \
        wget -q "https://github.com/intel/compute-runtime/releases/download/${INTEL_COMPUTE_RUNTIME_VERSION}/intel-opencl-icd_${INTEL_COMPUTE_RUNTIME_VERSION}_amd64.deb" && \
        # Install packages in dependency order to avoid issues
        dpkg -i intel-gmmlib_22.5.2_amd64.deb || true && \
        dpkg -i intel-igc-core_1.0.17791.9_amd64.deb || true && \
        dpkg -i intel-igc-opencl_1.0.17791.9_amd64.deb || true && \
        dpkg -i intel-level-zero-gpu_1.3.30872.22_amd64.deb || true && \
        dpkg -i intel-opencl-icd_${INTEL_COMPUTE_RUNTIME_VERSION}_amd64.deb || true && \
        # Fix any dependency issues
        apt-get install -f -y && \
        rm -rf /tmp/*.deb && \
        ldconfig; \
    else \
        echo "Intel GPU libraries not available for $(uname -m) architecture"; \
    fi

# Copy entrypoint script
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Switch back to ollama user
USER ollama

# Set environment variables for Intel GPU detection
ENV ONEAPI_DEVICE_SELECTOR=level_zero:gpu
ENV SYCL_CACHE_PERSISTENT=1

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["serve"]