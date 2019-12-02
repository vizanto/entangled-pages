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

Comming soon ...

:::::

<footer><address>2019 Johan Hidding, [![Netherlands eScience Center](img/escience_black.png)](https://esciencecenter.nl)</address></footer>
