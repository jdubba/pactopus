# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.0.0] - 2025-08-12

### Changed - BREAKING
- Complete rewrite focused on simplicity
- Removed multi-distribution support - now Fedora only
- Removed package sets concept - single flat list in `packages.conf`
- Removed Ansible dependency - direct bash/dnf implementation
- Simplified from ~660 lines to ~410 lines of code

### Added
- Proper CLI command structure (`install`, `update`, `list`, `status`, `help`)
- Colored output for better user feedback
- State tracking in `~/.config/pactopus/state.conf`
- Dotfiles integration (automatic clone and setup)
- Special package installers for:
  - Starship prompt
  - NVM (Node Version Manager)
  - AWS CLI v2
  - Azure CLI
  - VS Code
  - Brave Browser
- Package status indicators in list command (✓ for installed)

### Removed
- Multi-distribution package mappings
- Complex package set definitions and references
- Ansible playbooks requirement
- Support for Ubuntu, Arch, and other distributions

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