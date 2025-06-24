# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.5] - 2025-06-24

### Added
- **Package Sets System**: Revolutionary composable package management
  - New `src/playbooks/package-sets/` directory structure
  - `server-packages` set with 18 essential server tools
  - Intelligent deduplication logic prevents duplicate installations
  - Unified `install` and `remove` commands work with both packages and package sets
  - Automatic package set content parsing and classification

- **Major Development Package Expansion**: 13+ new development packages
  - **Build Tools**: `autoconf` - GNU Autotools configure script generator with comprehensive cross-distribution support
  - **Compilers**: `gcc` - GNU Compiler Collection with compilation testing and optimization guidance
  - **Programming Languages**: 
    - `python3` - Python 3 with pip, venv, and development headers across all distributions
    - `nodejs` - Node.js with LTS preference via NodeSource for stable distributions
    - `nvm` - Node Version Manager with shell integration and version management
  - **Cloud Tools**: `aws-cli` - AWS CLI v2 using official installer with security best practices
  - **Containerization**: `docker` - Docker Engine with official repositories, user group configuration, and service management

### Enhanced
- **Unified Command Interface**: Single install/remove commands handle both packages and package sets seamlessly
  - `pactopus install server-packages git` - Installs set and deduplicates individual packages
  - Intelligent classification system automatically detects package vs package set
  - Clear user feedback about deduplication decisions
- **Advanced Installation Strategies**:
  - **Distribution-aware logic**: Rolling distributions use native packages, stable use official sources
  - **Repository management**: Automatic addition of official repositories (Docker, NodeSource)
  - **User-space installations**: NVM, AWS CLI install to user directories without sudo
  - **Service configuration**: Docker automatically starts service and adds user to docker group
- **Comprehensive Package Documentation**: Each package includes detailed usage examples, security notes, and next steps
- **Enhanced Help System**: Categorized package listing (Development Tools, System Tools, Cloud & Containers)

### Refactored
- **Directory Structure Reorganization**:
  - Moved all individual packages from `src/playbooks/{package}/` to `src/playbooks/packages/{package}/`
  - Added `src/playbooks/package-sets/` for composable package collections
  - Updated CLI path resolution and Makefile installation to handle new structure
- **Package Set Architecture**:
  - Extensible YAML-based package set definitions with metadata
  - Content extraction system for deduplication analysis
  - Separate execution pipelines for packages vs package sets

### Fixed
- **Shell Compatibility**: Fixed NVM installation to use bash instead of sh for `source` command
- **YAML Syntax**: Resolved f-string syntax issues in Python3 playbook shell commands
- **Path Resolution**: Updated all playbook path detection to work with new directory structure

### Technical Improvements
- **Sophisticated Deduplication Algorithm**: Prevents installing individual packages already included in package sets
- **Mixed Installation Strategies**: Handles combinations of native packages, official installers, and user-space tools
- **Enhanced Error Handling**: Better validation for missing dependencies (curl, unzip) and graceful fallbacks
- **Cross-Distribution Package Mapping**: Comprehensive package name variations across Linux distributions

## [0.1.4] - 2025-06-24

### Added
- New package support for HTTP tools and AI assistance:
  - `wget` - GNU Wget file downloader with comprehensive HTTP/HTTPS/FTP support
  - `sudo` - Superuser access control with security configuration guidance
  - `which` - Command location finder with intelligent provider detection on Debian/Ubuntu
  - `xh` - HTTPie-compatible HTTP client written in Rust for fast API testing
  - `yai` - Command-line AI assistant supporting multiple providers (OpenAI, Anthropic, Google, Ollama)

### Enhanced
- Package management system improvements:
  - Intelligent sudo validation that only prompts when playbooks actually require elevated privileges
  - Enhanced provider detection for system packages on Debian/Ubuntu distributions
  - Better symlink resolution for command location detection
  - Improved error handling for packages without version flags
- Cross-distribution installation strategies:
  - Native package management for rolling distributions (Arch, Fedora)
  - GitHub binary releases for stable distributions with user-space installation
  - Automatic cleanup of temporary files during installation
- User experience improvements:
  - Comprehensive usage examples and configuration hints for each package
  - Clear installation method reporting (native package vs binary release)
  - Enhanced help text with complete package listing

### Fixed
- Fixed `which` package installation on Pop!_OS and other Debian/Ubuntu derivatives
- Resolved provider detection issues with symlinked commands managed by alternatives system
- Improved exit code handling to prevent false failure reports for successful installations
- Better handling of packages that don't support standard version flags

### Changed
- Updated package list in CLI help and error messages to include all new packages
- Enhanced package installation output with better status reporting and troubleshooting information

## [0.1.3] - 2025-06-23

### Added
- Cross-platform OS detection functionality supporting major Linux distributions
- Comprehensive ansible environment management with automatic installation
- pipx integration for isolated Python package management
- Support for ansible community collections installation and version checking
- New CLI commands:
  - `pactopus setup` - Automatic ansible and dependencies installation
  - `pactopus check` - System requirements and ansible status verification

### Changed
- Updated minimum version requirements:
  - Ansible core minimum version: 2.10 (previously 8.0.0)
  - Ansible community collections minimum version: 8.0.0
- Modernized ansible installation process to use pipx instead of direct pip/system packages
- Enhanced version comparison logic to handle semantic versioning properly
- Improved cross-distribution package management strategy

### Fixed
- Better error handling for unsupported operating systems
- Improved PATH management for pipx installations
- More robust version detection for ansible and community collections

## [0.1.2] - 2025-06-23

### Added
- Basic ansible integration framework
- OS family detection for package management strategy selection

### Changed
- Preparation for ansible-based package management implementation

## [0.1.1] - 2025-06-23

### Added
- Enhanced Makefile install process to install user scripts from `src/user/` directory
- User scripts are now installed to `~/.local/share/pactopus/bin/` and symlinked to `~/.local/bin/`
- Syntax checking for all user scripts in the `check` target
- Shellcheck linting for all user scripts in the `lint` target
- Comprehensive uninstall process that removes all installed scripts and directories

### Changed
- Updated GPG key passphrase functionality in `register-github-gpgkey` script to:
  - Capture password twice with confirmation
  - Show masked input using `read -sp`
  - Loop until passphrases match with clear error messaging
- Enhanced Makefile with new variables for shared directories and user script paths

### Fixed
- Improved security of password input in GPG key registration script

## [0.1.0] - 2025-06-23

### Added
- Initial code structure setup and basic CLI tool implementation
- Help and version commands for the main `pactopus` CLI
- Makefile setup for common tasks such as installation, testing, and linting
- User scripts for GitHub configuration:
  - `configure-github` - GitHub account configuration
  - `configure-github-repo` - Repository setup
  - `register-github-gpgkey` - GPG key registration for GitHub
- Documentation and initial release planning