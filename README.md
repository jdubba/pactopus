# Pactopus

A simple package management tool for Fedora that installs a curated list of development and productivity tools.

## Overview

Pactopus automates the setup of a complete development environment on Fedora systems. It reads a simple list of packages from a configuration file and installs them all with a single command. It handles both standard DNF packages and special installations for tools that require custom setup.

## Features

- **Single command installation** - Install all tools with `pactopus install`
- **Simple configuration** - Just a flat list of packages in `packages.conf`
- **Special package handling** - Automated setup for tools not in standard repos
- **Dotfiles integration** - Automatically configures your environment
- **State tracking** - Remembers installation status
- **Idempotent** - Safe to run multiple times

## Quick Start

```bash
# Clone the repository
git clone https://github.com/yourusername/pactopus.git
cd pactopus

# Install pactopus
make install

# Install all packages
pactopus install
```

## Usage

```bash
pactopus install    # Install all packages from packages.conf
pactopus update     # Update all installed packages
pactopus list       # Show all packages and their status
pactopus status     # Show installation status
pactopus help       # Display help
```

## What Gets Installed

The default `packages.conf` includes:

**Core Tools**: git, neovim, vim, curl, wget, make, tmux, zsh  
**Search & Files**: ripgrep, fzf, fd-find, bat, eza, tree  
**Development**: gcc, nodejs, python3, golang, rust, docker, podman  
**Cloud Tools**: terraform, ansible, kubectl, AWS CLI, Azure CLI  
**Desktop Apps**: kitty, firefox, VS Code, Brave Browser  
**Utilities**: htop, tldr, lazygit, jq, pass  

See [packages.conf](packages.conf) for the complete list.

## Customization

To customize what gets installed, simply edit `packages.conf`:

```bash
# packages.conf
git
neovim
docker
nodejs
starship      # SPECIAL - requires custom installation
```

- Add one package per line
- Lines starting with `#` are comments
- Add `# SPECIAL` for packages needing custom installation

## Special Packages

Some tools require custom installation methods:

| Package | Installation Method |
|---------|-------------------|
| starship | Official installer script |
| nvm | Git clone and setup |
| awscli2 | Direct download from AWS |
| azure-cli | Microsoft repository |
| code | Microsoft repository |
| brave-browser | Brave repository |

## Dotfiles Integration

Pactopus automatically:
1. Clones https://github.com/jdubba/dotfiles/ to `~/.dotfiles`
2. Runs the dotfiles installation
3. Configures your shell and tools

## Requirements

- Fedora Workstation 39 or later
- sudo access
- Internet connection

## File Locations

- **Config**: `packages.conf` in the project directory
- **State**: `~/.config/pactopus/state.conf`
- **Dotfiles**: `~/.dotfiles/`
- **User scripts**: Installed to `~/.local/bin/`

## Development

```bash
# Check syntax
make check

# Lint with shellcheck
make lint

# Uninstall
make uninstall
```

## Implementation

Pactopus is a simple bash script (~400 lines) that:
1. Reads packages from `packages.conf`
2. Separates regular vs special packages
3. Installs regular packages via `dnf`
4. Runs custom installers for special packages
5. Sets up dotfiles
6. Tracks state for updates

## Future Plans

- Add more special package installers
- Support for removing packages
- Backup/restore of package lists
- Multiple configuration profiles

## Contributing

To add new packages:
1. Add to `packages.conf`
2. If it needs special installation, mark with `# SPECIAL`
3. Add installation logic to `install_special_package()` function
4. Test on fresh Fedora system

## License

See [LICENSE](LICENSE) file for details.