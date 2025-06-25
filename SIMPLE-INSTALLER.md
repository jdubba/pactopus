# Simple Package Installer

A straightforward script-based package installer for Pactopus that works across Arch Linux, Fedora, and Ubuntu.

## Usage

```bash
# Install server packages
./simple-install.sh server-packages

# Install development environment
./simple-install.sh development-packages

# Install full workstation setup
./simple-install.sh full-workstation

# Install multiple sets at once
./simple-install.sh server-packages cloud-packages
```

## Available Package Sets

- **server-packages** - Essential server tools (git, neovim, ripgrep, etc.)
- **cloud-packages** - Cloud provider CLIs (AWS, Azure)
- **development-packages** - Development tools and compilers
- **basic-workstation** - Desktop essentials + server packages
- **full-workstation** - Complete development environment
- **gnome-packages** - GNOME desktop extras
- **hyprland-packages** - Hyprland window manager tools

## Adding New Packages

### Method 1: Edit packages.conf
Add a line in the format:
```
package_name:arch_name:fedora_name:ubuntu_name
```

Use `SKIP` if a package isn't available on a platform.
Use `SPECIAL` if a package needs custom installation logic.

### Method 2: Add to package sets
Edit the `install_package_set()` function in `simple-install.sh` to add packages to existing sets or create new sets.

## Examples

### Adding a simple package
```bash
# Add to packages.conf
htop:htop:htop:htop
```

### Adding a package with different names
```bash
# Add to packages.conf  
fd:fd:fd-find:fd-find
```

### Adding a package that needs special handling
```bash
# Add to packages.conf
my-special-tool:SPECIAL:SPECIAL:SPECIAL

# Add handler in install_special_package() function
my-special-tool)
    if ! command -v my-special-tool &> /dev/null; then
        echo "Installing my-special-tool..."
        # Custom installation logic here
    fi
    ;;
```

## Features

- **Idempotent** - Safe to run multiple times
- **Cross-platform** - Handles package name differences automatically
- **Extensible** - Easy to add new packages and package sets
- **Simple** - No complex dependencies, just bash and system package managers

## File Structure

- `simple-install.sh` - Main installer script
- `packages.conf` - Package name mappings for each distribution
- `SIMPLE-INSTALLER.md` - This documentation

## Updating Packages

Simply run the script again with the same arguments. It will:
1. Update package databases
2. Install any new packages added to the sets
3. Skip packages that are already installed
4. Update existing packages through the system package manager
