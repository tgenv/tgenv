# TGEnv — Developer Makefile
#
# Convenience targets for working on the project locally, including the
# MkDocs documentation site under ./docs.
#
# Run `make help` to list all available targets.

PIP    := pip
MKDOCS := mkdocs

.DEFAULT_GOAL := help

.PHONY: help
help: ## Show this help message
	@awk 'BEGIN {FS = ":.*?## "; printf "\nUsage: make <target>\n\nTargets:\n"} \
		/^[a-zA-Z_-]+:.*?## / {printf "  \033[36m%-22s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

# ---------------------------------------------------------------------------
# Documentation (MkDocs + Material)
# ---------------------------------------------------------------------------

.PHONY: docs-install
docs-install: ## Install MkDocs and Material theme (pip install mkdocs-material)
	$(PIP) install mkdocs-material

.PHONY: docs-start
docs-start: ## Start the local dev server with live reload (http://localhost:8000)
	$(MKDOCS) serve

.PHONY: docs-build
docs-build: ## Build the static site into site/ (same command CI runs)
	$(MKDOCS) build

.PHONY: docs-deploy
docs-deploy: ## Deploy docs directly to GitHub Pages via mkdocs gh-deploy
	$(MKDOCS) gh-deploy --force

.PHONY: docs-clean
docs-clean: ## Remove generated artifacts (site/)
	rm -rf site

.PHONY: docs-check
docs-check: docs-build ## Full validation pipeline used before opening a PR
	@echo ""
	@echo "Documentation build succeeded. Output: site/"

# ---------------------------------------------------------------------------
# Shell scripts (TGEnv itself)
# ---------------------------------------------------------------------------

.PHONY: lint
lint: ## Run shellcheck on bin/, libexec/ and test/
	shellcheck test/* bin/* libexec/*

.PHONY: test
test: ## Run the TGEnv test suite locally
	./test/run.sh
