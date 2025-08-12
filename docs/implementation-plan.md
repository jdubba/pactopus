# Pactopus Implementation Plan

## Overview
This document outlines the implementation plan for Pactopus v2, a simplified package management tool focused on Fedora Workstation.

## Current Status
- ✅ Basic package installation working
- ✅ Package sets configuration
- ❌ Simplified to Fedora-only
- ❌ State tracking
- ❌ Update command
- ❌ Dotfiles integration

## Implementation Sprints

### Sprint 1: Core Simplification (Week 1)
**Goal**: Simplify existing code to Fedora-only implementation

#### Tasks:
- [ ] Rewrite pactopus script
  - Remove multi-distro detection
  - Remove platform-specific package mappings
  - Focus on dnf commands only
  - Implement proper CLI structure with commands
  
- [ ] Simplify packages.conf
  - Remove distribution columns
  - Simple format: package name only
  - Mark special packages clearly
  
- [ ] Add state tracking
  - Create `~/.config/pactopus/state.conf`
  - Track installed package sets
  - Track installation timestamps
  
- [ ] Implement core commands
  - `pactopus install <sets...>`
  - `pactopus update`
  - `pactopus list`
  - `pactopus help`

#### Deliverables:
- Functional pactopus script for Fedora
- Simplified configuration
- Basic state management

### Sprint 2: Package Management (Week 2)
**Goal**: Complete package installation features

#### Tasks:
- [ ] Define standard package sets
  - base (git, neovim, ripgrep, fzf, etc.)
  - development (gcc, nodejs, docker, python3, etc.)
  - cloud (aws-cli, azure-cli)
  - workstation (kitty, brave-browser)
  
- [ ] Implement special installations
  - Starship prompt
  - NVM (Node Version Manager)
  - AWS CLI
  - Azure CLI
  - Brave Browser
  
- [ ] Add package validation
  - Check if packages exist in dnf
  - Handle missing packages gracefully
  - Provide clear error messages

### Sprint 3: Enhanced Features (Week 3)
**Goal**: Add dotfiles integration and user tools

#### Tasks:
- [ ] Dotfiles integration
  - Clone/pull https://github.com/jdubba/dotfiles/
  - Run `make install` in dotfiles repo
  - Execute `dotfiles install` command
  
- [ ] User tools management
  - Install scripts from `src/user/`
  - Create symlinks in `~/.local/bin/`
  - Ensure PATH includes user bin directory
  
- [ ] Status command
  - Show installed package sets
  - Display last update time
  - List special packages status

### Sprint 4: Polish and Testing (Week 4)
**Goal**: Testing, documentation, and polish

#### Tasks:
- [ ] Create test suite
  - Test installation on fresh Fedora
  - Verify idempotency
  - Test all package sets
  
- [ ] Update documentation
  - Update README with new approach
  - Create user guide
  - Document how to add new packages
  
- [ ] Error handling
  - Network failure recovery
  - Partial installation handling
  - Rollback capabilities

## Technical Decisions

### Why Fedora First?
- Modern package versions in repos
- DNF is powerful and well-documented
- Good balance of stability and freshness
- Developer-friendly distribution

### Why Remove Ansible?
- Reduces complexity significantly
- Direct bash/dnf is sufficient for single platform
- Easier to debug and maintain
- Faster execution

### State Management Design
```bash
# ~/.config/pactopus/state.conf
[installed_sets]
base=2024-01-15T10:30:00
development=2024-01-15T10:35:00

[installed_packages]
neovim=0.9.5
docker=24.0.7
```

### Package Definition Format
```bash
# packages.conf
[PACKAGE_SET:base]
git
neovim
ripgrep
fzf
bat
starship    # SPECIAL

[PACKAGE_SET:development]
@base       # Include another set
gcc
nodejs
docker
python3
```

## Success Metrics
1. **Installation Time**: < 5 minutes for base set on fast connection
2. **Idempotency**: Second run completes in < 30 seconds
3. **Error Rate**: < 1% failure rate on supported packages
4. **Code Simplicity**: < 500 lines of bash code total

## Risk Mitigation
| Risk | Mitigation |
|------|------------|
| Package not in dnf repo | Provide special installation method |
| Network failures | Implement retry logic |
| Conflicting packages | Let dnf handle conflicts |
| State corruption | Validate state file on each run |

## Future Considerations
- **Multi-distro support**: Structure code to easily add Ubuntu/Arch later
- **Package removal**: Track what pactopus installed vs system packages
- **Profiles**: Different configurations for different machine types
- **Plugins**: Allow external package definitions

## Timeline
- **Week 1**: Core simplification and basic commands
- **Week 2**: Package management and special installations  
- **Week 3**: Dotfiles and user tools
- **Week 4**: Testing and documentation
- **Total**: 4 weeks to production-ready v2