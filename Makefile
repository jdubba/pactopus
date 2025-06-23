# Pactopus Makefile

# Variables
PREFIX ?= $(HOME)/.local
BINDIR = $(PREFIX)/bin
SRCDIR = src

# Main executable
EXECUTABLE = pactopus

# Version
VERSION = 0.1.0

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
	@cp $(SRCDIR)/$(EXECUTABLE) $(BINDIR)/$(EXECUTABLE)
	@chmod +x $(BINDIR)/$(EXECUTABLE)
	@echo "Installation complete!"
	@echo "Make sure $(BINDIR) is in your PATH"

# Uninstall
uninstall:
	@echo "Removing pactopus from $(BINDIR)..."
	@rm -f $(BINDIR)/$(EXECUTABLE)
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