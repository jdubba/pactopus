# Pactopus Makefile

# Variables
PREFIX ?= $(HOME)/.local
BINDIR = $(PREFIX)/bin
SHAREDIR = $(PREFIX)/share/pactopus
SHAREBIN = $(SHAREDIR)/bin
SRCDIR = src
USERDIR = $(SRCDIR)/user

# Main executable
EXECUTABLE = pactopus

# Version
VERSION = 0.1.3

# Default target
all: check

# Check script syntax
check:
	@echo "Checking bash script syntax..."
	@bash -n $(SRCDIR)/$(EXECUTABLE)
	@for script in $(USERDIR)/*; do \
		if [ -f "$$script" ]; then \
			echo "Checking $$script..."; \
			bash -n "$$script"; \
		fi; \
	done
	@echo "Syntax check passed!"

# Install the executable
install: check
	@echo "Installing pactopus to $(BINDIR)..."
	@mkdir -p $(BINDIR)
	@mkdir -p $(SHAREBIN)
	@cp $(SRCDIR)/$(EXECUTABLE) $(BINDIR)/$(EXECUTABLE)
	@chmod +x $(BINDIR)/$(EXECUTABLE)
	@echo "Installing user scripts to $(SHAREBIN)..."
	@for script in $(USERDIR)/*; do \
		if [ -f "$$script" ]; then \
			scriptname=$$(basename "$$script"); \
			echo "Installing $$scriptname..."; \
			cp "$$script" "$(SHAREBIN)/$$scriptname"; \
			chmod +x "$(SHAREBIN)/$$scriptname"; \
			ln -sf "$(SHAREBIN)/$$scriptname" "$(BINDIR)/$$scriptname"; \
		fi; \
	done
	@echo "Installation complete!"
	@echo "Make sure $(BINDIR) is in your PATH"

# Uninstall
uninstall:
	@echo "Removing pactopus from $(BINDIR)..."
	@rm -f $(BINDIR)/$(EXECUTABLE)
	@echo "Removing user scripts..."
	@for script in $(USERDIR)/*; do \
		if [ -f "$$script" ]; then \
			scriptname=$$(basename "$$script"); \
			echo "Removing $$scriptname..."; \
			rm -f "$(BINDIR)/$$scriptname"; \
		fi; \
	done
	@echo "Removing $(SHAREDIR)..."
	@rm -rf $(SHAREDIR)
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
		for script in $(USERDIR)/*; do \
			if [ -f "$$script" ]; then \
				echo "Linting $$script..."; \
				shellcheck "$$script"; \
			fi; \
		done; \
		echo "Lint check passed!"; \
	else \
		echo "shellcheck not installed. Skipping lint check."; \
	fi

.PHONY: all check install uninstall test clean lint