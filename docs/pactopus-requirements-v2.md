# Pactopus v2 - Ultra-Simplified Requirements

## Overview
Pactopus is a simple package installer for Fedora that reads a list of packages from a configuration file and installs them all with one command.

## Core Philosophy
- **Dead simple** - One config file, one list of packages
- **Fedora only** - No multi-distro complexity
- **No abstractions** - Direct use of dnf and bash
- **Minimal configuration** - Edit one file to customize

## Functional Requirements

### 1. Package Installation
- Read package names from `packages.conf`
- Install via `dnf install` for standard packages
- Run custom installers for special packages
- Skip already installed packages (idempotent)

### 2. Special Packages
Handle tools not in DNF repos:
- Starship (installer script)
- NVM (git clone)
- AWS CLI (direct download)
- Azure CLI (Microsoft repo)
- VS Code (Microsoft repo)
- Brave Browser (Brave repo)

### 3. Dotfiles Integration
- Clone/update https://github.com/jdubba/dotfiles/
- Run dotfiles installation

### 4. User Tools
- Install scripts from `src/user/` to `~/.local/bin/`

## Technical Requirements

### Platform
- **OS**: Fedora Workstation 39+
- **Package Manager**: dnf
- **Shell**: bash
- **Privileges**: sudo for package installation

### Commands
```bash
pactopus install    # Install all packages
pactopus update     # Update all packages
pactopus list       # Show packages and status
pactopus status     # Show last install info
pactopus help       # Show help
```

### Configuration Format
```bash
# packages.conf - one package per line
git
neovim
docker
starship      # SPECIAL - custom installation
```

### State Management
Track in `~/.config/pactopus/state.conf`:
- Last installation timestamp
- Version number

### Project Structure
```
/
├── src/
│   ├── pactopus        # Main script (~400 lines)
│   └── user/           # User scripts
├── packages.conf       # Package list
├── Makefile           # Install/uninstall
└── README.md          # Documentation
```

## Implementation Details

### Main Script Flow
1. Parse `packages.conf`
2. Separate regular vs special packages
3. Install regular packages via dnf
4. Install special packages with custom logic
5. Setup dotfiles
6. Save state

### Package Detection
- Regular packages: Check with `rpm -q`
- Special packages: Custom detection per package
- Show checkmarks for installed packages

## Success Criteria
1. Install all packages with one command
2. Second run completes quickly (idempotent)
3. Clear feedback during installation
4. Simple to customize package list

## Non-Goals
- Package sets or groups
- Multi-distribution support
- Package removal
- Version pinning
- Dependency resolution (let dnf handle it)
- Complex configuration

## Future Considerations
- Could add profiles later (minimal.conf, full.conf)
- Could add other distros later (ubuntu.conf)
- Keep the core simple - resist feature creep