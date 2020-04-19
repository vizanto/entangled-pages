---
title: Entangled
subtitle: literate programming for the new millennium
---
:::: {#topbar}
[[About Entangled](index.html#section-entangled)
 [Get started](index.html#section-markdown)
]{#navigation}
[[![Octocat](img/github.png) Find us on Github](https://github.com/entangled/entangled)&nbsp;
 [![Download](img/download.svg) Download Entangled](https://github.com/entangled/entangled/releases)
]{#logobar}
::::

::::: {#content}

# Installing

There are currently two parts to Entangled: the `entangled` daemon and the `entangled-filters` set of Pandoc filters.

## Installing Entangled

### Pre-compiled binaries

For Windows 10 and Debian/Ubuntu based machines there is a pre-compiled binary available in the [release section on Github](https://github.com/entangled/entangled/releases). Note that on Ubuntu, you need to set your `LOCALE` to a UTF-8 encoding, for example by putting `export LANG=en_GB.UTF-8` in your `.bashrc`.

### Building Entangled

To compile from source, a minimum GHC version of 8.6 is required. Most GNU/Linux distributions ship an older version of Haskell. The easiest way to install a newer version is through [GHCUp](https://www.haskell.org/ghcup/). Builds have been tested against GHC 8.6 and 8.8. Entangled is not very big, but it has dependencies that may take a while to build. Clone the repository at [https://github.com/entangled/entangled](https://github.com/entangled/entangled), and run

        cabal build
        cabal install

## Installing Entangled Filters

The `entangled-filters` package is available on PyPI:

        pip install entangled-filters

# Starting a project

We offer a set of tools that can help you in managing a literate program, create a workflow towards generating results, publish nice web-pages, generate PDFs etc. There's no absolutes on how to use these tools. One component that you'll absolutely need is a build system. In this introduction we'll use [GNU Make](https://gnu.org/s/make). The `Makefile` may redirect to another build system for specific languages (`npm` for Javascript, `cabal` for Haskell, `cargo` for Rust, etc.).

## Use a template

The easiest way to start a project is to use a template. We provide a template for creating a Bootstrap 4 page. To use this template, first install `cookiecutter` with

```bash
pip install cookiecutter
```

Then run

```bash
cookiecutter https://github.com/entangled/bootstrap
```

You will be prompted for a project name, author, version, etc. See the [Entangled Bootstrap Template](https://entangled.github.io/bootstrap) for more info.

## Starting from scratch

Make has the curious property of being, not only indentation sensitive, it requires tabs for indentation. To lift this annoying property we start the `Makefile` with a special `.RECIPEPREFIX` clause.

``` {.makefile file=dragon/Makefile}
.RECIPEPREFIX +=

<<make-greeting>>
<<make-phonies>>
<<make-help>>
<<make-build>>
<<make-pages>>
<<make-clean>>
```

Our `Makefile` will have four main targets:

``` {.makefile #make-phonies}
.PHONY: help build pages clean
```

- `help` print a friendly help message
- `build` build the application from source
- `pages` create html, suitable for a `github.io` page.
- `clean` remove all `build` and `pages` targets

The first thing that we want to do with the `Makefile`, is offer some documentation on how to use it!

### Offering help

Just another great Pandoc hack! Using the [`Orange-OpenSource/pandoc-terminal-writer`](https://github.com/Orange-OpenSource/pandoc-terminal-writer) package, we can pipe Pandoc output, pretty printed to the terminal. This writer is just a [single `lua` file](https://raw.githubusercontent.com/Orange-OpenSource/pandoc-terminal-writer/master/terminal.lua) which you can include with your distribution: put it in a `filters` directory.

Let's add some documentation to the `Makefile`:

``` {.makefile #make-greeting}
#| My awesome Literate Programming project
#| =======================================
#|
#| This Makefile either generates a beautiful report, builds
#| code, generates graphs or all of those at once.
#|
#| Usage
#| -----
#|
#|     make [help|build|pages|clean]
#|
```

It is good form to add a list of prerequisites; noone reads readmes these days.

``` {.makefile #make-greeting}
#| Prerequisites
#| -------------
#|
#| - Pandoc >= 2.0
#| - Python >= 3.7
#| - Python packages: entangled-filters
#| - Rust
```

Note that these everything starting with `#` is a comment in Make, but we also include a `|` character. We can filter on those lines and pipe them through Pandoc.

``` {.makefile #make-help}
help:
	@ grep -e '^#|' Makefile \
	| sed -e 's/^#| \?\(.*\)/\1/' \
	| pandoc -f markdown -t filters/terminal.lua \
	| fold -s -w 80
```

:::::

<footer><address>2020 Johan Hidding, [![Netherlands eScience Center](img/escience_black.png)](https://esciencecenter.nl)</address></footer>
