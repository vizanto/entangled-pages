# Steps
These are the recommended steps to start a project using Entangled.

0. Install prerequisites
    - Python
    - NodeJS
    - Pandoc ([Pandoc documentation](https://pandoc.org/MANUAL.html)
    - Entangled
    - `inotify-tools`
    - `tmux`
    - Dhall, `dhall-to-json` (see [Dhall JSON tutorial](https://docs.dhall-lang.org/tutorials/Getting-started_Generate-JSON-or-YAML.html))
    - Entangled filters (`pip install --user entangled-filters`)
    - BrowserSync (`npm install -g browser-sync`)
In principle `inotify-tools` is Linux only, but there is [a Windows port](https://github.com/thekid/inotify-win). On Mac, there is `fswatch` which has a different interface.

1. Starting with an empty folder, and initialize version control

```bash
mkdir project
cd project
git init
```

2. Clone the Bootstrap template

```bash
git submodule add git@github.com:entangled/bootstrap-submodule bootstrap
```

4. Create the first Markdown file

~~~bash
mkdir lit
cat > lit/index.md <<EOF
---
title: Hello World
author: Hannah Johnson
---

Literate programming is awesome!

``` {.python #hello-world}
print("Hello, World!")
```
EOF
~~~

5. Create a Makefile (there is an example in the `bootstrap-submodule` project). Change the `input_files` variable to the list of your Markdown sources.

```bash
cp bootstrap/Makefile.example Makefile
{vim|nano|emacs} Makefile
```

6. Build the website. The result will appear in `./docs/index.html`

```bash
make site
```

7. Create the `entangled.dhall` file.

```bash
entangled config > entangled.dhall
{vim|nano|emacs} entangled.dhall
```

Once you do this more often, you may not want the overly verbose default configuration file. To generate a minimal configuration, run `entangled config -m` instead.

8. Make watch.

```bash
make watch
```

This last step should start three sub-windows in the terminal:
    1. Inotify loop to rebuild the website with `make site`
    2. Browser-sync to automatically reload the page in your browser
    3. Entangled to keep Markdown and program code in sync

Have fun!

9. Pro tip: check out the [Pandoc documentation on templates](https://pandoc.org/MANUAL.html#templates), and play around with `template.html` and `mods.css`. Create a fork of the `bootstrap-submodule` repository to save your settings.

