# Pactopus Makefile

# Variables
PREFIX ?= $(HOME)/.local
BINDIR = $(PREFIX)/bin
ETCDIR = $(PREFIX)/etc/pactopus
SRCDIR = src

# Main executable
EXECUTABLE = pactopus

# Version
VERSION = 2.0.0

# Default target
all: check

# Check script syntax
check:
	@echo "Checking bash script syntax..."
	@bash -n $(SRCDIR)/$(EXECUTABLE)
	@echo "Syntax check passed!"

# Install the executable
install: check
	@echo "Installing pactopus to $(BINDIR)..."
	@mkdir -p $(BINDIR)
	@mkdir -p $(ETCDIR)
	@cp $(SRCDIR)/$(EXECUTABLE) $(BINDIR)/$(EXECUTABLE)
	@chmod +x $(BINDIR)/$(EXECUTABLE)
	@echo "Installing configuration files to $(ETCDIR)..."
	@cp packages.conf $(ETCDIR)/packages.conf
	@if [ -f gnome-packages.conf ]; then \
		cp gnome-packages.conf $(ETCDIR)/gnome-packages.conf; \
	fi
	@if [ -f gnome-extensions.conf ]; then \
		cp gnome-extensions.conf $(ETCDIR)/gnome-extensions.conf; \
	fi
	@echo "Installation complete!"
	@echo "Make sure $(BINDIR) is in your PATH"

# Uninstall
uninstall:
	@echo "Removing pactopus from $(BINDIR)..."
	@rm -f $(BINDIR)/$(EXECUTABLE)
	@echo "Removing $(ETCDIR)..."
	@rm -rf $(ETCDIR)
	@echo "Uninstall complete!"

# Test installation
test:
	@echo "Testing pactopus installation..."
	@if command -v pactopus >/dev/null 2>&1; then \
		echo "✓ pactopus found in PATH"; \
		pactopus version; \
	else \
		echo "✗ pactopus not found in PATH"; \
		echo "  Make sure $(BINDIR) is in your PATH"; \
		exit 1; \
	fi

# Clean (nothing to clean for now)
clean:
	@echo "Nothing to clean"

# Lint the bash script
lint:
	@echo "Running shellcheck..."
	@if command -v shellcheck >/dev/null 2>&1; then \
		shellcheck $(SRCDIR)/$(EXECUTABLE); \
		echo "Lint check passed!"; \
	else \
		echo "shellcheck not installed. Skipping lint check."; \
	fi

.PHONY: all check install uninstall test clean lint