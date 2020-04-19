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
sources := index.md setting-up.md eval-and-doctest.md
html_tgts := $(sources:%.md=$(build_dir)/%.html)
style := nlesc.css fonts.css
style_tgts := $(style:%=$(build_dir)/%)
images := $(shell find img/*)
image_tgts := $(images:%=$(build_dir)/%)
js := $(shell find js/*.js)
js_tgts := $(js:js/%=$(build_dir)/%)

pandoc_args := -s -t html5
pandoc_args += --highlight-style style/syntax.theme
pandoc_args += --filter pandoc-citeproc --mathjax
pandoc_args += --filter pandoc-annotate-codeblocks
pandoc_args += --css nlesc.css

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
watch: $(html_tgts) $(build_dir)/img $(style_tgts)
	@tmux new-session make --no-print-directory watch-pandoc \; \
		split-window -v make --no-print-directory watch-browser \; \
		select-layout even-vertical \;

watch-pandoc:
	@while true; do \
		inotifywait -e close_write $(sources:%=src/%) style/* Makefile img/*; \
		make build; \
	done

watch-browser:
	browser-sync start -s $(build_dir) -f $(build_dir) --no-notify

#| * `clean`: clean reveal.js and docs
clean:
	rm -rf $(build_dir)

build: $(html_tgts) $(style_tgts) $(image_tgts) $(js_tgts) $(build_dir)/fonts

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
	@mkdir -p $(build_dir)/fonts
	cp fonts/* $(build_dir)/fonts

.PHONY: all clean build watch watch-pandoc watch-browser

