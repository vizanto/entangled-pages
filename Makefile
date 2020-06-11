# This is a suggestion for a Makefile. This assumes you have executed,
#
#     git submodule add git@github.com:entangled/bootstrap-submodule bootstrap
#
# and that you have your literate sources in `./lit`.
#
# Make sure you have the following things installed:
#
#   - Entangled (the daemon)
#   - entangled-filters (the pandoc filters: pip install ...)
#   - Pandoc
#   - BrowserSync (npm install -g ...)
#   - InotifyTools (available from most GNU/Linux distributions)
#
# The website will be built in `./docs`, from which it can be served as
# github.io pages.
#
#
# You should list the Markdown sources here in the order that they should
# appear.
input_files := lit/index.md lit/tutorial.md lit/manual.md
html_targets := $(input_files:lit/%.md=docs/%.html)

# Arguments to Pandoc; these are reasonable defaults
pandoc_args += --template bootstrap/template-topbar.html
pandoc_args += --css css/nlesc.css
pandoc_args += --css css/code-examples.css
pandoc_args += -t html5 -s --mathjax --toc
pandoc_args += --toc-depth 1
pandoc_args += --filter pandoc-doctest
pandoc_args += --filter pandoc-bootstrap
pandoc_args += --filter pandoc-citeproc
pandoc_args += --filter pandoc-fignos
pandoc_args += -f markdown+multiline_tables+simple_tables

# Load syntax definitions for languages that are not supported
# by default. These XML files are in the format of the Kate editor.
pandoc_args += --syntax-definition bootstrap/elm.xml
pandoc_args += --syntax-definition bootstrap/pure.xml
pandoc_args += --syntax-definition bootstrap/dhall.xml
# pandoc_args += --highlight-style tango
pandoc_args += --highlight-style style/syntax.theme

# Any file in the `lit` directory that is not a Markdown source 
# is to be copied to the `docs` directory
static_files := $(shell find -L lit -type f -not -name '*.md')
static_targets := $(static_files:lit/%=docs/%)

.PHONY: site clean watch watch-pandoc watch-browser-sync

# This should build everything needed to generate your web site. That includes
# possible Javascript targets that may need compiling.
site: $(html_targets) docs/css/nlesc.css $(static_targets)

clean:
	rm -rf docs

# Starts a tmux with Entangled, Browser-sync and an Inotify loop for running
# Pandoc.
watch:
	@tmux new-session make --no-print-directory watch-pandoc \; \
		split-window -v make --no-print-directory watch-browser-sync \; \
		split-window -v entangled daemon \; \
		select-layout even-vertical \;

watch-pandoc:
	@while true; do \
		inotifywait -e close_write bootstrap lit Makefile; \
		make site; \
	done

watch-browser-sync:
	browser-sync start -w -s docs

publish:
	cd docs && git commit -a -m "automatic update" && git push

$(html_targets): docs/%.html: lit/%.md bootstrap/template-topbar.html Makefile
	@mkdir -p docs
	pandoc $(pandoc_args) $< -o $@

docs/css/nlesc.css: bootstrap/nlesc.css
	@mkdir -p docs/css
	cp $< $@

$(static_targets): docs/%: lit/%
	@mkdir -p $(dir $@)
	cp $< $@

