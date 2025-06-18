# Pactopus

A cross-distribution personal package management DSC (Desired State Configuration) tool for standardizing tool sets across multiple Linux machines and environments.

## Overview

Pactopus manages the installation and configuration of software packages across various Linux distributions, providing a consistent environment whether you're working on a remote server, minimal workstation, or full development machine. It uses Ansible playbooks to handle platform-specific variations while maintaining a unified interface.

## Features

- **Cross-distribution support** - Works across 20+ Linux distributions including Debian, Ubuntu, Fedora, RHEL, Arch, Alpine, and more
- **Composable package sets** - Define reusable groups of packages that can be combined (e.g., server-packages, development-packages)
- **Platform-aware installation** - Automatically handles package name variations and chooses appropriate installation methods
- **User tools management** - Install and manage custom scripts and utilities alongside system packages
- **Dotfiles integration** - Automatically configures your environment using your dotfiles repository
- **Idempotent operations** - Safe to run multiple times without side effects

## Supported Platforms

### Rolling Release Distributions
- Arch Linux
- Fedora Workstation/Server
- CentOS Stream
- OpenSUSE Tumbleweed

### Stable Release Distributions
- Debian and derivatives (Ubuntu, Mint, Pop!_OS)
- RHEL and derivatives (AlmaLinux, Rocky Linux)
- Amazon Linux 2
- Alpine Linux
- OpenSUSE

## Installation

```bash
# Clone the repository
git clone https://github.com/yourusername/pactopus.git
cd pactopus

# Build and install
make
make install
```

## Usage

```bash
# Display help
pactopus help

# Install package sets
pactopus install server-packages development-packages

# Install individual packages
pactopus install neovim docker

# Update all installed packages
pactopus update
```

## Package Sets

Pactopus includes predefined package sets for common use cases:

- **server-packages** - Essential tools for remote servers (git, neovim, ripgrep, etc.)
- **cloud-packages** - Cloud provider CLIs (AWS, Azure)
- **development-packages** - Development tools and compilers
- **basic-workstation** - Desktop essentials (includes server-packages)
- **full-workstation** - Complete development environment

See [docs/pactopus-initial-package-lists.md](docs/pactopus-initial-package-lists.md) for the complete list.

## Development

See [docs/release-v1.0.0.md](docs/release-v1.0.0.md) for the implementation roadmap and progress tracking.

### Project Structure

```
/
├── src/
│   ├── user/          # User-defined scripts and tools
│   └── playbooks/     # Ansible playbooks for package installation
├── docs/              # Project documentation
├── tests/             # Test suite
└── Makefile          # Build and installation scripts
```

### Testing

```bash
# Run unit tests
make test

# Lint code
make lint
```

## Contributing

Contributions are welcome! Please ensure all tests pass and code is properly linted before submitting pull requests.

## License

See [LICENSE](LICENSE) file for details.
