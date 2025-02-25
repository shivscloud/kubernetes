#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status

echo "🚀 Installing kubectl..."

# Detect OS Architecture
ARCH=$(uname -m)

if [[ "$ARCH" == "x86_64" ]]; then
    URL="https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
elif [[ "$ARCH" == "aarch64" ]]; then
    URL="https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/arm64/kubectl"
else
    echo "❌ Unsupported architecture: $ARCH"
    exit 1
fi

# Download kubectl
curl -LO "$URL"

# Make it executable
chmod +x kubectl

# Move to system path
sudo mv kubectl /usr/local/bin/

# Verify installation
echo "✅ kubectl installed successfully!"
kubectl version --client
