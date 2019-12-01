#| Makefile
#| ========
#|
#| Write your presentation in Markdown. This `Makefile` lets you watch the sources
#| and preview the presentation, live in your browser.
#|
#| Usage
#| -----
#|
#|     make [help|clean|watch|pages]
#|
#| Prerequisites
#| -------------
#|
#| * Pandoc
#| * Node (stable)
#| * inotify-tools
#|

build_dir := build
src_dir := src
source := $(src_dir)/index.md
style := dark.css
images := $(shell find img/*)
image_tgts := $(images:%=$(build_dir)/%)
js := $(shell find js/*.js)
js_tgts := $(js:js/%=$(build_dir)/%)

pandoc_args := -s -t html5
pandoc_args += --highlight-style style/syntax.theme
pandoc_args += --filter pandoc-citeproc --mathjax
pandoc_args += --lua-filter filters/annotate-code-blocks.lua
pandoc_args += --css dark.css

#|
#| Targets
#| -------

#| * `help`: print this help
help:
	@ grep -e '^#|' Makefile \
	| sed -e 's/^#| \?\(.*\)/\1/' \
	| pandoc -f markdown -t filters/terminal.lua \
	| fold -s -w 80

#| * `watch`: reload browser upon changes
watch: $(build_dir)/index.html $(build_dir)/img $(build_dir)/$(style)
	@tmux new-session make --no-print-directory watch-pandoc \; \
		split-window -v make --no-print-directory watch-browser \; \
		select-layout even-vertical \;

watch-pandoc:
	@while true; do \
		inotifywait -e close_write $(source) style/* Makefile img/*; \
		make build; \
	done

watch-browser:
	browser-sync start -s $(build_dir) -f $(build_dir) --no-notify

#| * `clean`: clean reveal.js and docs
clean:
	rm -rf $(build_dir)

build: $(build_dir)/index.html $(build_dir)/$(style) $(image_tgts) $(js_tgts) $(build_dir)/fonts

# Rules ============================================

$(build_dir)/%.js: js/%.js
	@mkdir -p $(build_dir)
	cp $< $@

$(build_dir)/%.html: $(src_dir)/%.md style/syntax.theme filters/annotate-code-blocks.lua Makefile
	@mkdir -p $(build_dir)
	pandoc $(pandoc_args) -o $@ $<

$(build_dir)/img/%: img/%
	@mkdir -p $(build_dir)/img
	cp -r img/* $(build_dir)/img

$(build_dir)/%.css: style/%.css
	@mkdir -p $(build_dir)
	cp $< $@

$(build_dir)/fonts: fonts
	@mkdir -p $(build_dir)
	cp -r $< $@

.PHONY: all clean build watch watch-pandoc watch-browser

