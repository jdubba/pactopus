#!/bin/bash

# Pactopus Simple Package Installer
# Supports: Arch Linux, Fedora, Ubuntu
# Usage: ./install-packages.sh [package-set1] [package-set2] ...

set -e

# Detect distribution
detect_distro() {
    if command -v pacman &> /dev/null; then
        echo "arch"
    elif command -v dnf &> /dev/null; then
        echo "fedora"
    elif command -v apt &> /dev/null; then
        echo "ubuntu"
    else
        echo "Unsupported distribution" >&2
        exit 1
    fi
}

# Install packages based on distribution
install_package() {
    local package="$1"
    local distro="$2"
    
    echo "Installing: $package"
    
    case "$distro" in
        arch)
            if ! pacman -Qi "$package" &> /dev/null; then
                sudo pacman -S --noconfirm "$package" || echo "Warning: Failed to install $package"
            fi
            ;;
        fedora)
            if ! rpm -q "$package" &> /dev/null; then
                sudo dnf install -y "$package" || echo "Warning: Failed to install $package"
            fi
            ;;
        ubuntu)
            if ! dpkg -l | grep -q "^ii  $package "; then
                sudo apt install -y "$package" || echo "Warning: Failed to install $package"
            fi
            ;;
    esac
}

# Update package databases
update_system() {
    local distro="$1"
    
    echo "Updating package databases..."
    case "$distro" in
        arch)
            sudo pacman -Sy
            ;;
        fedora)
            sudo dnf check-update || true
            ;;
        ubuntu)
            sudo apt update
            ;;
    esac
}

# Main installation function
install_packages() {
    local package_set="$1"
    local distro="$2"
    
    # Source the package definitions
    source "$(dirname "$0")/package-definitions.sh"
    
    case "$package_set" in
        server-packages)
            install_server_packages "$distro"
            ;;
        cloud-packages)
            install_cloud_packages "$distro"
            ;;
        development-packages)
            install_development_packages "$distro"
            ;;
        basic-workstation)
            install_server_packages "$distro"
            install_basic_workstation_packages "$distro"
            ;;
        full-workstation)
            install_server_packages "$distro"
            install_basic_workstation_packages "$distro"
            install_development_packages "$distro"
            install_cloud_packages "$distro"
            install_full_workstation_packages "$distro"
            ;;
        gnome-packages)
            install_gnome_packages "$distro"
            ;;
        hyprland-packages)
            install_hyprland_packages "$distro"
            ;;
        *)
            echo "Unknown package set: $package_set"
            echo "Available sets: server-packages, cloud-packages, development-packages, basic-workstation, full-workstation, gnome-packages, hyprland-packages"
            exit 1
            ;;
    esac
}

# Main script
main() {
    local distro
    distro=$(detect_distro)
    
    echo "Detected distribution: $distro"
    
    if [ $# -eq 0 ]; then
        echo "Usage: $0 [package-set1] [package-set2] ..."
        echo "Available package sets:"
        echo "  server-packages"
        echo "  cloud-packages" 
        echo "  development-packages"
        echo "  basic-workstation"
        echo "  full-workstation"
        echo "  gnome-packages"
        echo "  hyprland-packages"
        exit 1
    fi
    
    update_system "$distro"
    
    for package_set in "$@"; do
        echo "Installing package set: $package_set"
        install_packages "$package_set" "$distro"
    done
    
    echo "Installation complete!"
}

main "$@"
