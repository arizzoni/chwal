# Makefile for chwal installation

# functional tests
# better examples

PREFIX ?= /usr/local
DESTDIR ?=
BINDIR := $(DESTDIR)$(PREFIX)/bin
MANDIR := $(DESTDIR)$(PREFIX)/share/man/man1
COMPDIR_BASH := $(DESTDIR)$(PREFIX)/share/bash-completion/completions

INSTALL := install
INSTALL_PROGRAM := $(INSTALL) -m 755
INSTALL_DATA := $(INSTALL) -m 644

SCRIPT := chwal
MANPAGE := chwal.1

MAKE_DEPS := shellcheck checkbashisms txt2man
SCRIPT_DEPS := wallust

all: info ## Show the help message by default

check: check-make check-script ## Check all dependencies

check-make: ## Check for Makefile-required tools
	@errors=0
	@for cmd in $(MAKE_DEPS); do \
		if ! command -v $$cmd > /dev/null 2>&1; then \
			printf 'Missing Makefile dependency: %s\n' $$cmd; \
			errors=1; \
		fi; \
	done;
	@exit $$errors

check-script: ## Check for script dependencies
	@errors=0
	@for cmd in $(SCRIPT_DEPS); do \
		if ! command -v $$cmd > /dev/null 2>&1; then \
			printf 'Missing script dependency: %s\n' $$cmd; \
			errors=1; \
		fi; \
	done;
	@exit $$errors

clean: ## Remove generated files
	@rm -f chwal.1

info: ## Show the help message
	@echo "Usage: make <target>"
	@echo ""
	@echo "Available targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## ' Makefile \
	| sed -E 's/^([a-zA-Z_-]+):.*## (.*)/  \1\t\2/' \
	| expand -t20

install: check test man ## Install script, completions, and manpage
	$(INSTALL) -d$(BINDIR)$(MANDIR)$(COMPDIR_BASH)
	$(INSTALL_PROGRAM) $(SCRIPT) $(BINDIR)/chwal
	$(INSTALL_DATA) $(MANPAGE) $(MANDIR)/chwal.1
	$(INSTALL_DATA) completions/chwal-completion.bash $(COMPDIR_BASH)/chwal

chwal.1: $(SCRIPT) Makefile
	@if [ -f 'chwal.1' ] && [ -s 'chwal.1' ]; then rm -f chwal.1; fi
	@printf '.TH chwal 1 "$(date -I)" "chwal 1.0" "" \n' >> chwal.1
	@printf ".SH NAME\n" >> chwal.1
	@printf ".B chwal - Wallpaper and colorscheme selector using wallust.\n" >> chwal.1
	@printf "Version $$(grep '^# Version' $(SCRIPT) | head -n1 | cut -d' ' -f3)\n" >> chwal.1
	@printf "\n" >> chwal.1
	@printf ".SH SYNOPSIS\n" >> chwal.1
	@printf "chwal [OPTIONS]\n" >> chwal.1
	@printf "" >> chwal.1
	@printf ".SH DESCRIPTION\n" >> chwal.1
	@printf "This script randomly selects wallpapers from a directory and applies a colorscheme using wallust. It supports theme caching, marking wallpapers for removal, and optional pre/post hooks.\n" >> chwal.1
	@printf "\n" >> chwal.1
	@printf ".SH COMMAND OPTIONS\n" >> chwal.1
	@chmod +x $(SCRIPT) && ./$(SCRIPT) -h 2> /dev/null  >> chwal.1
	@printf "\n" >> chwal.1
	@printf ".SH EXAMPLES\n" >> chwal.1
	@printf "chwal -d /path/to/wallpapers -l\n" >> chwal.1
	@printf "chwal -r\n" >> chwal.1
	@printf "\n" >> chwal.1
	@printf ".SH INSTALLATION\n" >> chwal.1
	@printf "This project uses GNU Make to generate documentation and shell completion files. To install chwal, the manpages, and the shell completions simply run 'make install' and everything will go to the correct location.\n" >> chwal.1
	@printf "\n" >> chwal.1
	@printf "  .B TARGETS\n" >> chwal.1
	@grep -E '^[a-zA-Z_-]+:.*?## ' Makefile \
	| sed -E 's/^([a-zA-Z_-]+):.*## (.*)/  \1  \2/' >> chwal.1
	@printf "\n\n" >> chwal.1
	@printf ".SH AUTHOR\n" >> chwal.1
	@printf "Alessandro Rizzoni <rizzoni.alex@gmail.com>\n" >> chwal.1
	@printf "" >> chwal.1
	@printf ".SH LICENSE\n" >> chwal.1
	@printf "This software is licensed under the terms of the the MIT License. The full license text has been included in this package according to the license." >> chwal.1

man: chwal.1 ## Generate manpage

test: check-make ## Run test scripts
	@errors=0
	@for cmd in $(MAKE_DEPS); do \
		if ! $$cmd $(SCRIPT); then \
			printf '%s failed.\n' "$$cmd"; \
			errors=1; \
		fi; \
	done;
	@exit $$errors

uninstall: ## Uninstall script, completions, and manpage
	rm -f $(BINDIR)/chwal
	rm -f $(MANDIR)/chwal.1
	rm -f $(COMPDIR_BASH)/chwal_completion.bash

.PHONY: install man man2 test check check-make check-script info clean uninstall 
