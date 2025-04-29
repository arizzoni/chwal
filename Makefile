# Makefile for chwal installation

# functional tests
# better examples
SHELL := /bin/sh
PREFIX ?= /usr/local
DESTDIR ?=
BINDIR := /usr/local/bin
MANDIR := /usr/local/share/man/man1
COMPDIR_BASH := /usr/share/bash-completion/completions

INSTALL := install
INSTALL_PROGRAM := $(INSTALL) -m 755
INSTALL_DATA := $(INSTALL) -m 644

SCRIPT := chwal
MANPAGE := chwal.1

MAKE_DEPS := shellcheck checkbashisms
SCRIPT_DEPS := wallust

all: help ## Show the help message by default

check: ## Check all dependencies
	@errors=0
	@for cmd in $(MAKE_DEPS); do \
		if ! command -v $$cmd > /dev/null 2>&1; then \
			printf 'Missing Makefile dependency: %s\n' $$cmd; \
			errors=1; \
		fi; \
	done;
	@for cmd in $(SCRIPT_DEPS); do \
		if ! command -v $$cmd > /dev/null 2>&1; then \
			printf 'Missing script dependency: %s\n' $$cmd; \
			errors=1; \
		fi; \
	done;
	@for cmd in $(MAKE_DEPS); do \
		if ! $$cmd $(SCRIPT); then \
			printf '%s failed.\n' "$$cmd"; \
			errors=1; \
		fi; \
	done;
	@exit $$errors

clean: ## Remove generated files
	@rm -f chwal.1

help: ## Show the help message
	@echo "Usage: make <target>"
	@echo ""
	@echo "Available targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## ' Makefile \
	| sed -E 's/^([a-zA-Z_-]+):.*## (.*)/  \1\t\2/' \
	| expand -t20

install: check man ## Install script, completions, and manpage
	$(INSTALL) -d $(BINDIR)
	$(INSTALL) -d $(MANDIR)
	$(INSTALL) -d $(COMPDIR_BASH)
	$(INSTALL_PROGRAM) $(SCRIPT) $(BINDIR)/chwal
	$(INSTALL_DATA) $(MANPAGE) $(MANDIR)/chwal.1
	$(INSTALL_DATA) completions/chwal $(COMPDIR_BASH)/chwal

chwal.1: $(SCRIPT) Makefile
	@if [ -f 'chwal.1' ] && [ -s 'chwal.1' ]; then rm -f chwal.1; fi
	@VERSION=$$(grep '^# Version' $(SCRIPT) | sed 's/# Version //'); \
	printf '.TH chwal 1 "%s" "chwal %s" ""\n' "$$(date +%Y-%m-%d)" "$$VERSION" >> chwal.1
	@printf ".SH NAME\n" >> chwal.1
	@printf ".B chwal - Wallpaper and colorscheme selector using wallust.\n" >> chwal.1
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
	@printf "\n" >> chwal.1
	@printf "chwal -m\n" >> chwal.1
	@printf "\n" >> chwal.1
	@printf ".SH INSTALLATION\n" >> chwal.1
	@printf "This project uses GNU Make to generate documentation and shell completion files. To install chwal, the manpages, and the shell completions simply run 'make install' and everything will go to the correct location.\n" >> chwal.1
	@printf "\n" >> chwal.1
	@printf ".B TARGETS\n" >> chwal.1
	@grep -E '^[a-zA-Z_-]+:.*?## ' Makefile \
	| sed -E 's/^([a-zA-Z_-]+):.*## (.*)/  \1  \2/' >> chwal.1
	@printf "\n\n" >> chwal.1
	@printf ".SH AUTHOR\n" >> chwal.1
	@printf "Alessandro Rizzoni <rizzoni.alex@gmail.com>\n" >> chwal.1
	@printf "" >> chwal.1
	@printf ".SH LICENSE\n" >> chwal.1
	@cat './LICENSE' >> chwal.1

man: chwal.1 ## Generate manpage

uninstall: ## Uninstall script, completions, and manpage
	rm -f $(BINDIR)/chwal
	rm -f $(MANDIR)/chwal.1
	rm -f $(COMPDIR_BASH)/chwal

.PHONY: check clean help install man uninstall
