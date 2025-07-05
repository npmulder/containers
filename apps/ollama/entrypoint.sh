#!/bin/bash

set -e

echo "Starting Ollama..."

# Execute the original ollama command
exec /bin/ollama "$@"