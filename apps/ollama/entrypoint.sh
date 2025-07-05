#!/bin/bash

set -e

# Check if Intel GPU libraries are available
echo "Checking Intel GPU support..."

# Check for Level Zero
if ls /usr/lib/x86_64-linux-gnu/libze_loader.so* >/dev/null 2>&1; then
    echo "✓ Intel Level Zero GPU runtime found"
    export ZE_FLAT_DEVICE_HIERARCHY=FLAT
else
    echo "⚠ Intel Level Zero GPU runtime not found"
fi

# Check for OpenCL
if ls /usr/lib/x86_64-linux-gnu/libOpenCL.so* >/dev/null 2>&1; then
    echo "✓ Intel OpenCL ICD found"
else
    echo "⚠ Intel OpenCL ICD not found"
fi

# List available GPU devices if any
if command -v clinfo >/dev/null 2>&1; then
    echo "Available OpenCL devices:"
    clinfo -l || echo "No OpenCL devices found"
fi

# Check for Intel GPU device files
if ls /dev/dri/render* >/dev/null 2>&1; then
    echo "✓ Intel GPU device files found:"
    ls -la /dev/dri/render*
else
    echo "⚠ No Intel GPU device files found in /dev/dri/"
fi

# Set Intel GPU environment variables
export ONEAPI_DEVICE_SELECTOR=level_zero:gpu
export SYCL_CACHE_PERSISTENT=1

echo "Starting Ollama with Intel GPU support..."

# Execute the original ollama command
exec /bin/ollama "$@"