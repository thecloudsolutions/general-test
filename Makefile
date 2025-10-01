SHELL := /bin/bash

export README_FILE ?= README.md
export README_YAML ?= README.yaml
export README_TEMPLATE_FILE ?= README.md.gotmpl

install-gomplate:
	@if ! command -v gomplate &>/dev/null; then \
		echo "Installing gomplate..."; \
		curl -sSL https://github.com/hairyhenderson/gomplate/releases/latest/download/gomplate_linux-amd64 -o ./gomplate; \
		chmod +x ./gomplate; \
		mv ./gomplate /usr/local/bin/gomplate; \
	fi

install-terraform-docs:
	@if ! command -v terraform-docs &>/dev/null; then \
		echo "Installing terraform-docs..."; \
		curl -Lo ./terraform-docs.tar.gz https://github.com/terraform-docs/terraform-docs/releases/download/v0.19.0/terraform-docs-v0.19.0-linux-amd64.tar.gz; \
		tar -xzf terraform-docs.tar.gz; \
		chmod +x terraform-docs; \
		mv terraform-docs /usr/local/bin/terraform-docs; \
		rm terraform-docs.tar.gz; \
	fi

install: install-gomplate install-terraform-docs

readme/other: install
	@mkdir -p docs
	@if [ -f .terraform-docs.yml ]; then \
		terraform-docs . > docs/terraform.md; \
	elif [ -f .terraform-docs.other.yml ]; then \
		terraform-docs --config .terraform-docs.other.yml . > docs/terraform.md; \
	fi
	@sed -i 's/^      //g' docs/terraform.md
	@sed -i 's|git@github.com:thecloudsolutions|thecloudsolutions|g' docs/terraform.md
	@gomplate --file $(README_TEMPLATE_FILE) --out $(README_FILE)
	@echo "Generated $(README_FILE)"

readme/general: install-gomplate
	@gomplate --file $(README_TEMPLATE_FILE) --out $(README_FILE)
	@echo "Generated $(README_FILE)"

.PHONY: readme/other readme/general install install-gomplate install-terraform-docs
