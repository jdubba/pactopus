#!/bin/bash

# Package definitions for different distributions
# Format: install_package "package-name-for-distro" "$distro"

install_server_packages() {
    local distro="$1"
    
    install_package "git" "$distro"
    install_package "gawk" "$distro"
    install_package "make" "$distro"
    install_package "curl" "$distro"
    install_package "stow" "$distro"
    install_package "fzf" "$distro"
    install_package "bat" "$distro"
    install_package "wget" "$distro"
    install_package "sudo" "$distro"
    install_package "which" "$distro"
    
    # Distribution-specific package names
    case "$distro" in
        arch)
            install_package "bash-completion" "$distro"
            install_package "fastfetch" "$distro"
            install_package "ripgrep" "$distro"
            install_package "neovim" "$distro"
            ;;
        fedora)
            install_package "bash-completion" "$distro"
            install_package "fastfetch" "$distro"
            install_package "ripgrep" "$distro"
            install_package "neovim" "$distro"
            ;;
        ubuntu)
            install_package "bash-completion" "$distro"
            # fastfetch may need snap or manual install on older Ubuntu
            install_package "ripgrep" "$distro"
            install_package "neovim" "$distro"
            ;;
    esac
    
    # Special installations that need custom handling
    install_special_packages "$distro"
}

install_cloud_packages() {
    local distro="$1"
    
    case "$distro" in
        arch)
            # AWS CLI available in AUR
            echo "Note: AWS CLI and Azure CLI may need AUR installation on Arch"
            ;;
        fedora)
            install_package "awscli" "$distro"
            # Azure CLI needs Microsoft repo
            ;;
        ubuntu)
            # AWS CLI and Azure CLI need special installation
            echo "Note: AWS CLI and Azure CLI need manual installation on Ubuntu"
            ;;
    esac
}

install_development_packages() {
    local distro="$1"
    
    # Common development tools
    install_package "autoconf" "$distro"
    install_package "automake" "$distro"
    install_package "binutils" "$distro"
    install_package "bison" "$distro"
    install_package "file" "$distro"
    install_package "findutils" "$distro"
    install_package "flex" "$distro"
    install_package "gcc" "$distro"
    install_package "libtool" "$distro"
    install_package "m4" "$distro"
    install_package "make" "$distro"
    install_package "patch" "$distro"
    install_package "sed" "$distro"
    install_package "texinfo" "$distro"
    install_package "python3" "$distro"
    
    case "$distro" in
        arch)
            install_package "fakeroot" "$distro"
            install_package "glibc" "$distro"  # equivalent to libc6-dev
            install_package "groff" "$distro"
            install_package "gzip" "$distro"
            install_package "nodejs" "$distro"
            install_package "npm" "$distro"
            install_package "docker" "$distro"
            install_package "go" "$distro"
            install_package "rust" "$distro"
            install_package "jdk-openjdk" "$distro"
            ;;
        fedora)
            install_package "fakeroot" "$distro"
            install_package "glibc-devel" "$distro"
            install_package "groff" "$distro"
            install_package "gzip" "$distro"
            install_package "nodejs" "$distro"
            install_package "npm" "$distro"
            install_package "docker" "$distro"
            install_package "golang" "$distro"
            install_package "rust" "$distro"
            install_package "java-openjdk" "$distro"
            ;;
        ubuntu)
            install_package "fakeroot" "$distro"
            install_package "libc6-dev" "$distro"
            install_package "dpkg-dev" "$distro"
            install_package "gettext" "$distro"
            install_package "groff" "$distro"
            install_package "gzip" "$distro"
            install_package "g++" "$distro"
            install_package "nodejs" "$distro"
            install_package "npm" "$distro"
            install_package "docker.io" "$distro"
            install_package "golang" "$distro"
            install_package "rustc" "$distro"
            install_package "openjdk-11-jdk" "$distro"
            ;;
    esac
}

install_basic_workstation_packages() {
    local distro="$1"
    
    case "$distro" in
        arch)
            install_package "kitty" "$distro"
            # Brave browser needs AUR
            install_package "github-cli" "$distro"
            ;;
        fedora)
            install_package "kitty" "$distro"
            # Brave browser needs special repo
            install_package "gh" "$distro"
            ;;
        ubuntu)
            install_package "kitty" "$distro"
            # Brave browser needs special repo
            install_package "gh" "$distro"
            ;;
    esac
}

install_full_workstation_packages() {
    local distro="$1"
    
    install_package "gimp" "$distro"
    
    case "$distro" in
        arch)
            install_package "libwebp" "$distro"
            ;;
        fedora)
            install_package "libwebp" "$distro"
            ;;
        ubuntu)
            install_package "webp" "$distro"
            ;;
    esac
}

install_gnome_packages() {
    local distro="$1"
    
    case "$distro" in
        arch)
            install_package "gnome-extra" "$distro"
            ;;
        fedora)
            install_package "@gnome-desktop" "$distro"
            ;;
        ubuntu)
            install_package "gnome-shell-extensions" "$distro"
            install_package "ubuntu-gnome-desktop" "$distro"
            ;;
    esac
}

install_hyprland_packages() {
    local distro="$1"
    
    case "$distro" in
        arch)
            install_package "hyprpaper" "$distro"
            ;;
        fedora)
            echo "Note: Hyprland packages may need COPR repo on Fedora"
            ;;
        ubuntu)
            echo "Note: Hyprland packages may need manual installation on Ubuntu"
            ;;
    esac
}

install_special_packages() {
    local distro="$1"
    
    echo "Installing special packages that need custom handling..."
    
    # Starship prompt
    if ! command -v starship &> /dev/null; then
        echo "Installing Starship prompt..."
        curl -sS https://starship.rs/install.sh | sh -s -- -y
    fi
    
    # xh (HTTPie alternative)
    case "$distro" in
        arch)
            install_package "xh" "$distro"
            ;;
        fedora)
            install_package "xh" "$distro"
            ;;
        ubuntu)
            # May need snap or cargo install
            if command -v snap &> /dev/null; then
                sudo snap install xh
            fi
            ;;
    esac
    
    # ble.sh (Bash Line Editor)
    if [ ! -d "$HOME/.local/share/blesh" ]; then
        echo "Installing ble.sh..."
        git clone --recursive https://github.com/akinomyoga/ble.sh.git /tmp/ble.sh
        make -C /tmp/ble.sh install PREFIX="$HOME/.local"
        rm -rf /tmp/ble.sh
    fi
    
    # NVM (Node Version Manager)
    if [ ! -d "$HOME/.nvm" ]; then
        echo "Installing NVM..."
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
    fi
}
