FROM ollama/ollama:latest

USER root

# Install dependencies for Intel GPU support
RUN apt-get update && apt-get install -y \
    wget \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# renovate: datasource=github-releases depName=intel/compute-runtime
ARG INTEL_COMPUTE_RUNTIME_VERSION=24.35.30872.22

# Note: Intel GPU support temporarily disabled to fix user setup issues
# Will be re-added in a future update with proper dependency management

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