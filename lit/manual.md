---
title: Entangled
subtitle: the manual
footer: "[![](img/escience_white.png){style='height: 20pt'}](https://esciencecenter.nl/)"
license:  "[Apache 2](https://www.apache.org/licenses/LICENSE-2.0)"
github: "https://github.com/entangled/entangled/"
---

# Introduction
Entangled helps you write Literate Programs in Mardown. You put all your code inside Markdown code blocks. Entangled automatically extracts the code and writes it to more traditional source files. You can then edit these generated files, and the changes are being fed back to the Markdown.

``` {.bash .eval #entangled-version}
entangled --version
```

We refer to the Markdown files as 'source' and the traditional source code as 'targets'. Just to keep thigs confusing ;).

# Command-line
The entangled command-line tool has several sub-commands.

``` {.bash .eval #entangled-help}
entangled --help
```

There options here are global and may affect the operation of any of the sub-commands. The `-m` option makes all commands (except `daemon`) print out information in machine readable format:

----------------- ------------------------
`+ filename`      a file gets created
`~ filename`      a file gets modified
`- filename`      a file gets deleted
----------------- ------------------------

The `-c` option doesn't make changes to the file system, but it prints any action that would be done to `stdout` in machine readable format. If nothing would happen `entangled` returns exit code `0`, otherwise exit code `1`.

The command you'll be using most often is `daemon`. To understand what the daemon does, it is instructive to first see what the other commands do.

## Config
The `config` commands generates a valid configuration file.

``` {.bash .eval #entangled-help}
entangled config --help
```

The default file is very verbose with lots of explanation and comments. If you are more experienced, you may prefer the minimal file.

## Insert
The `insert` command reads one or more files and inserts them into the database.

``` {.bash .eval #entangled-help}
entangled insert --help
```

You need to specify if you want to insert source files (`-s|--source`) or target files (`-t|--target`).

## Tangle
The `tangle` command looks at the code blocks that are present in the database.

``` {.bash .eval #entangled-help}
entangled tangle --help
```

You may choose to query any named reference in your code (`-r|--ref`), or any specified target file (`-f|--file`). The expanded content of the given reference will be dumped to standard output. If you just want to write out all files to their proper location, use the `-a` or `--all` flag.

TODO: the `-d|--decorate` flag no longer does anything, since this is managed from the configuration file.

## Stitch
The `stitch` command extracts from the contents of the database any of the input markdown files. If a target file was changed and inserted, the contents will be different from those on the file system. The result is written to standard output.

``` {.bash .eval #entangled-help}
entangled stitch --help
```

TODO: implement `stitch -a`

## Clear orphans
The `clear-orphans` command deletes all orphan target files from the file system. A orphan target arises when a target file reference gets renamed or removed. By using this command, you make sure that these target files do not linger around. When you run the daemon, renaming a file will show up as creation of one target and anihilation of another.

``` {.bash .eval #entangled-help}
entangled clear-orphans --help
```

## List
The `list` command lists all the target files.

``` {.bash .eval #entangled-help}
entangled list --help
```

## Lint
The `lint` command is an assortment of analytical tools. These all work by querying the database for some information and reporting on it. Not all of these would fall in the realm of what you would call a linter.

``` {.bash .eval #entangled-help}
entangled lint --help
```

Currently there are two linters:

- `listUnusedFragments` --- Generates a list of all code fragments that do not end up in a target file. When this happens, it may indicate a spelling error in the name of a reference, which can lead to confusion.
- `dumpToGraphViz` --- Creates a graph of all references to be visualized with Graphviz, just because we can. Example:
  
  ```bash
  entangled lint dumpToGraphViz | dot -Tsvg -o refs.svg
  ```

TODO: add command to list all available linters

## Daemon
This starts a loop waiting for events on your filesystem. If any of the involved files is written to, the daemon will (effectively) run a set of fixed commands.

- In the case a Markdown source gets written to:

  ```bash
  entangled insert -s <changed file>
  entangled tangle -a
  entangled clear-orphans
  ```

- In the case a target file gets written to:

  ```bash
  entangled insert -t <changed file>
  entangled stitch -a
  entangled tangle -a
  ```

  That last tangle happens because some references inside one file may also be present in other files, or even multiple times in a single file.

# Configuration
The Entangled configuration is written in the [**Dhall language**](https://dhall-lang.org/). Dhall is very strict when it comes to following a schema, which is completely encoded in its type system. When you run `entangled config > entangled.dhall`, you'll get a configuration file that you can edit for greater hapiness. It should start with the following (or similar) lines:

``` {.bash #config .eval}
entangled config -m | head -n2
```

This imports the schema from the released version on Github. This is cached locally and checked against the hash key for integrity.
The Entangled configuration should follow the schema,

``` {.dhall #schema}
Config : { version    : Text
         , languages  : List entangled.Language
         , watchList  : List Text
         , database   : Optional Text
         , annotate   : entangled.Annotate
         , lineDirectives : List entangled.LineDirective
         , useLineDirectives : Bool }
```

The `version` item should never be touched, as it indicates the version of the schema being used.
The `languages` list contains a list of programming languages and their syntax for comments. You can add to this list as follows,

``` {.dhall #config}
let languages = entangled.languages #
    [ { name = "Bash", identifiers = ["bash", "sh"], comment = entangled.comments.hash } ]
```

The `watchList` gives the list of files that need to be watched by the daemon. You can use glob patterns here (see: [Hackage:System.FilePath.Glob](http://hackage.haskell.org/package/Glob-0.10.0/docs/System-FilePath-Glob.html#v:compile) for the complete supported syntax). A good value would be something like:

``` {.dhall #config}
let watchList = [ "lit/*.md" ]
```

The `database` option should point to the path name of the database file.

``` {.dhall #config}
let database = Some ".entangled/db.sqlite"
```

The configuration should always end in a statement starting with the `in` keyword, indicating the value being represented by the contents of the file.

``` {.dhall #config}
in { entangled = entangled.Config :: { database = database
                                     , watchList = watchList
                                     , languages = languages }
   }
```

The `::` operator updates the default values in left-hand side with those in the right-hand side.

## Types of annotation {#annotation-config}
The `annotate` option tells the method of annotation. Currently we support three values:

- `entangled.Annotate.Naked` --- No annotation, stitching will not work
- `entangled.Annotate.Standard` --- Standard annotation (default)
- `entangled.Annotate.Project` --- Includes a `project://source.md#42` directive in the annotation.
  This allows some editor plugins to easily jump from the source code to the relevant location in
  the Markdown. It has a major downside however: with every change line-numbers will change, leading
  to large commits, and frequent recompiles. To avoid the large commit probllem, Git can be configured
  with a `.gitattributes` filter to [strip the line numbers](https://github.com/entangled/entangled/pull/15#issuecomment-578096484) from diffs.

## Line directives
The `lineDirectives` option gives a list of line-directive patterns. Some languages have compiler directives to point to original source locations. For example, in C, you can say `#LINE 42 "source.md"`, and the compiler will know to point the user to line 42 in `source.md`. Currently included are C, C++ and Haskell, but you can add your own style following the pattern here. You can append on this list using the `#` operator, the same way as we did with the `languages` entry.

``` {.dhall #schema}
let lineDirectives =
    [ { name = "C",          format = "#line {linenumber} \"{filename}\"" }
    , { name = "C++",        format = "#line {linenumber} \"{filename}\"" }
    , { name = "Haskell",    format = "{{-# LINE {linenumber} \"{filename}\" #-}}" }
    ]
```

To use the line directives you need to set the `useLineDirectives` option to `True`. Note that this option has the same downside as the `Annotate.Project` annotation method. Source files will change often, and you will have frequent recompiles.

## Custom Markdown Syntax (since version 1.2.0) {#custom-syntax}
It may happen that you are working with a Markdown renderer that does not support the standard syntax that Entangled uses. In this case you can configure the syntax that Entangled parses using regular expressions. One instance where this is useful is in building sites with MkDocs (see [instructions on MkDocs](https://entangled.github.io/mkdocs)). The following syntax rules can be made to work with MkDocs.

``` {.dhall #config}
let syntax : entangled.Syntax =
    { matchCodeStart       = "^[ ]*```[[:alpha:]]+"
    , matchCodeEnd         = "^[ ]*```"
    , extractLanguage      = "```([[:alpha:]]+)"
    , extractReferenceName = "```[[:alpha:]]+[ ]+.*id=\"([^\"]*)\".*"
    , extractFileName      = "```[[:alpha:]]+[ ]+.*file=\"([^\"]*)\".*" 
    }
```

Note that all expressions used to extract part of the line (e.g. `extractLanguage` and relatives) **must have exactly one subexpression**.

# Standard syntax
The standard syntax is aimed to work well together with Pandoc. Every code block is delimited with three back ticks. Added to the opening line is a sequence of space separated **code properties**. These properties align with the CSS attributes that would end up in the generated HTML. For those unfamiliar with CSS:

- `#identifier`; a name prefixed with a `#` (sharp), identifies the object, only one of these should be present per item
- `.class`; a name prefixed with `.` (period), assigns the object to a class, a object can belong to any number of classes
- `key=value`; a name suffixed with `=` (equals), optionally followed by a value, adds any meta-data attribute to the object

The complete syntax of a code block then looks like:

~~~markdown
 ``` {[#<reference>|.<language>|<key>=<value>] ...}
 <code> ...
 ```
~~~

The first class in the code properties is always interpreted to give the **programming language** of the code block. In Entangled, any code block is one of the following:
    
- A **referable** block: has exactly one **reference id** (`#<reference>`) and one class giving the language of the code block (`.<language>`). Example:

  ~~~markdown
  ``` {.rust #hello-rust}
  println!("Hello, Rust!");
  ```
  ~~~
 
  In some cases you may want to have additional classes, for example `.bootstrap-fold` to enable a folded code block. Always the first class is interpreted to identify the language.
- A **file** block: has a key-value pair giving the path to the file (`file=<path>`), absolute or relative to the directory in which `entangled` runs. Again, there should be one class giving the language of the block (`.<language>`). Example:

  ~~~markdown
  ``` {.rust #main-function file=src/main.rs}
  fn main() {
     <<hello-rust>>
  }
  ```
  ~~~

  The identifier in a file block is optional. If it is left out, the identifier will silently be taken to be the file name.
- An **ignored** block: anything not matching the previous two.

# Tangle rules
Entangled recognizes three parameters for every code block. Since version 1.2 the way these parameters are extracted from an opening line may be [configured using regular expressions](#custom-syntax). Formally, every code block has three properties:

- `Language`
- `Identifier`
- `Optional Filename`

Entangled should tangle your code following these rules:

1. If an **identifier** is repeated the contents of the code blocks is concatenated in the order that they appear in the Markdown. If an identifier appears in multiple files, the order is dependent on the order by which the files appear in the configuration, or if they result from a glob-pattern expansion, alphabetical order.

2. Each **target file** is associated to one identifier, the content of which becomes the content of the tangled file. It is illegal to tie a filename to more than one different identifiers. For example, the following input should raise an error:

   ~~~markdown
   ``` {.rust #program file=main.rs}
   ```

   ``` {.rust file=main.rs}
   ```
   ~~~

   Because of the first statement, the file `main.rs` gets associated with the `#program` identifier; in the second statement, the file `main.rs` gets associated with the `#main.rs` identifier implicitely.

3. **Noweb references** are **expanded**. A noweb reference in Entangled should occupy a single line of code by itself, and is enclosed with double angle brackets, and maybe indented with white space. Space at the end of the line is ignored.

   ~~~txt
   +--- indentation ---+--- reference  ---+--- possible space ---+
                       <<noweb-reference>>
   ~~~

   The reference is expanded recursively, after which the indentation is prefixed to every line in the expanded reference content.

4. **Annotation**; Expanded and concatenated code blocks are annotated using comment lines. These lines should not be touched when editing the generated files. The default method of annotation follows an opening comment with `~\~ begin <<filename|identifier>>[n]`, and a closing comment with `~\~ end`. For example

   ~~~rust
   // ~\~ begin <<lit/index.md|main>>[1]
   println!("hello");
   // ~\~ end
   ~~~

   These comments can be configured to also include line numbers (see [annotation config](#annotation-config)).

