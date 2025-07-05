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
        # Download required Intel GPU packages
        wget -q "https://github.com/intel/compute-runtime/releases/download/${INTEL_COMPUTE_RUNTIME_VERSION}/intel-gmmlib_22.5.2_amd64.deb" && \
        wget -q "https://github.com/intel/compute-runtime/releases/download/${INTEL_COMPUTE_RUNTIME_VERSION}/intel-level-zero-gpu_1.3.30872.22_amd64.deb" && \
        wget -q "https://github.com/intel/compute-runtime/releases/download/${INTEL_COMPUTE_RUNTIME_VERSION}/intel-opencl-icd_${INTEL_COMPUTE_RUNTIME_VERSION}_amd64.deb" && \
        # Extract packages to avoid dependency conflicts
        dpkg-deb -x intel-gmmlib_22.5.2_amd64.deb /tmp/intel-gpu && \
        dpkg-deb -x intel-level-zero-gpu_1.3.30872.22_amd64.deb /tmp/intel-gpu && \
        dpkg-deb -x intel-opencl-icd_${INTEL_COMPUTE_RUNTIME_VERSION}_amd64.deb /tmp/intel-gpu && \
        # Copy libraries to system locations
        find /tmp/intel-gpu -name "*.so*" -exec cp {} /usr/lib/x86_64-linux-gnu/ \; && \
        # Create library path configuration
        echo "/usr/lib/x86_64-linux-gnu" >> /etc/ld.so.conf.d/intel-gpu.conf && \
        ldconfig && \
        rm -rf /tmp/intel-gpu /tmp/*.deb; \
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