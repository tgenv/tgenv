# TGEnv — Developer Makefile
#
# Convenience targets for working on the project locally, including the
# Docusaurus documentation site under ./docs.
#
# Run `make help` to list all available targets.

DOCS_DIR := docs
NPM      := npm

.DEFAULT_GOAL := help

.PHONY: help
help: ## Show this help message
	@awk 'BEGIN {FS = ":.*?## "; printf "\nUsage: make <target>\n\nTargets:\n"} \
		/^[a-zA-Z_-]+:.*?## / {printf "  \033[36m%-22s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

# ---------------------------------------------------------------------------
# Documentation (Docusaurus)
# ---------------------------------------------------------------------------

.PHONY: docs-install
docs-install: ## Install Docusaurus dependencies (npm ci)
	cd $(DOCS_DIR) && $(NPM) ci

.PHONY: docs-install-dev
docs-install-dev: ## Install Docusaurus dependencies for first run (npm install)
	cd $(DOCS_DIR) && $(NPM) install

.PHONY: docs-start
docs-start: ## Start the local dev server with hot reload (http://localhost:3000/tgenv/)
	cd $(DOCS_DIR) && $(NPM) start

.PHONY: docs-build
docs-build: ## Build the static site into docs/build (same command CI runs)
	cd $(DOCS_DIR) && $(NPM) run build

.PHONY: docs-serve
docs-serve: docs-build ## Build and serve the production bundle locally
	cd $(DOCS_DIR) && $(NPM) run serve

.PHONY: docs-clean
docs-clean: ## Remove generated artifacts (build, .docusaurus, node_modules)
	cd $(DOCS_DIR) && rm -rf build .docusaurus node_modules

.PHONY: docs-check
docs-check: docs-install docs-build ## Full validation pipeline used before opening a PR
	@echo ""
	@echo "Documentation build succeeded. Output: $(DOCS_DIR)/build"

# ---------------------------------------------------------------------------
# Shell scripts (TGEnv itself)
# ---------------------------------------------------------------------------

.PHONY: lint
lint: ## Run shellcheck on bin/, libexec/ and test/
	shellcheck test/* bin/* libexec/*

.PHONY: test
test: ## Run the TGEnv test suite locally
	./test/run.sh
