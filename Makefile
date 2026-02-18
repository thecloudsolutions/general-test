SHELL := /bin/bash

README_TYPE ?= $(if $(wildcard .terraform-docs.yml),terraform,general)
README_FILE := Makefile.readme.$(README_TYPE)

ifneq ($(filter $(README_TYPE),terraform general),$(README_TYPE))
$(error Invalid README_TYPE '$(README_TYPE)'. Use README_TYPE=terraform|general)
endif

# Download components (no authentication needed for public repos)
$(shell curl -sSL -o .Makefile.install https://raw.githubusercontent.com/thecloudsolutions/makefiles-public/refs/heads/main/Makefile.install)
$(shell curl -sSL -o .Makefile.readme https://raw.githubusercontent.com/thecloudsolutions/makefiles-public/refs/heads/main/$(README_FILE))
$(shell curl -sSL -o .Makefile.target https://raw.githubusercontent.com/thecloudsolutions/makefiles-public/refs/heads/main/Makefile.target)
$(shell curl -sSL -o .Makefile.clean https://raw.githubusercontent.com/thecloudsolutions/makefiles-public/refs/heads/main/Makefile.clean)
$(shell curl -sSL -o .Makefile.help https://raw.githubusercontent.com/thecloudsolutions/makefiles-public/refs/heads/main/Makefile.help)

# .Makefile.install:
# 	cp ../makefiles/Makefile.install $@

# .Makefile.readme:
# 	cp ../makefiles/$(README_FILE) $@

# .Makefile.target:
# 	cp ../makefiles/Makefile.target $@

# .Makefile.clean:
# 	cp ../makefiles/Makefile.clean $@

# .Makefile.help:
# 	cp ../makefiles/Makefile.help $@

# Include everything needed explicitly
include .Makefile.install
include .Makefile.readme
include .Makefile.target
include .Makefile.clean
include .Makefile.help
