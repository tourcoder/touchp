#!/bin/bash

# install.sh - Installation script for touchp
# This script detects the OS and architecture, then downloads and installs the appropriate touchp binary.
# Touchp - https://binhua.org/touchp

set -e  # Exit on error

# Base URL for downloading binaries
BASE_URL="https://dlc.binhua.org/touchp"
VERSION="v1.0.0"
INSTALL_DIR="/usr/local/bin"  # default
TEMP_DIR="/tmp/touchp-install"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'  # No Color

# Function to detect OS and architecture
detect_system() {
    OS=$(uname -s | tr '[:upper:]' '[:lower:]')
    ARCH=$(uname -m)

    case "$OS" in
        darwin)
            OS="macos"
            ;;
        linux)
            OS="linux"
            ;;
        msys*|cygwin*|mingw*)
            OS="windows"
            ;;
        *)
            echo -e "${RED}Error: Unsupported operating system: $OS${NC}"
            exit 1
            ;;
    esac

    case "$ARCH" in
        x86_64)
            ARCH="amd64"
            ;;
        arm64|aarch64)
            ARCH="arm64"
            ;;
        *)
            echo -e "${RED}Error: Unsupported architecture: $ARCH${NC}"
            exit 1
            ;;
    esac

    echo "Detected system: $OS-$ARCH"
}

# Function to download and install
install_binary() {
    BINARY="touchp-$OS-$ARCH-$VERSION"
    if [ "$OS" = "windows" ]; then
        BINARY="$BINARY.exe"
    fi
    DOWNLOAD_URL="$BASE_URL/$BINARY"

    # Create temp directory
    mkdir -p "$TEMP_DIR"
    cd "$TEMP_DIR"

    echo "Downloading $BINARY from $DOWNLOAD_URL..."
    curl -fsSL "$DOWNLOAD_URL" -o "$BINARY"
    if [ $? -ne 0 ]; then
        echo -e "${RED}Error: Failed to download $BINARY${NC}"
        exit 1
    fi

    # Make executable (non-Windows)
    if [ "$OS" != "windows" ]; then
        chmod +x "$BINARY"
    fi

    # Check if /usr/local/bin exists, if not, create it
    if [ ! -d "$INSTALL_DIR" ]; then
        echo "Directory $INSTALL_DIR does not exist. Creating it now..."
        sudo mkdir -p "$INSTALL_DIR"
        sudo chown $(whoami) "$INSTALL_DIR"  # Change ownership to the current user
    fi

    # Check if /usr/local/bin is writable
    if [ ! -w "$INSTALL_DIR" ]; then
        echo -e "${RED}Error: $INSTALL_DIR is not writable. Please check permissions.${NC}"
        exit 1
    fi

    # Move binary to install directory
    if [ "$OS" = "windows" ]; then
        echo "Windows detected. Please manually move $BINARY to a directory in your PATH."
        echo "File downloaded to: $TEMP_DIR/$BINARY"
    else
        sudo mv "$BINARY" "$INSTALL_DIR/touchp"
        echo -e "${GREEN}Successfully installed touchp to $INSTALL_DIR/touchp${NC}"
        echo "You can now run 'touchp --help' to get started."
    fi
}

# Main execution
echo "Starting touchp installation..."

# Detect system
detect_system

# Install binary
install_binary

# Clean up
rm -rf "$TEMP_DIR"

# Check if touchp is in PATH (non-Windows)
if [ "$OS" != "windows" ]; then
    if ! command -v touchp >/dev/null 2>&1; then
        echo "Note: $INSTALL_DIR is not in your PATH. You may need to add it:"
        echo "  export PATH=\$PATH:$INSTALL_DIR"
    fi
fi
