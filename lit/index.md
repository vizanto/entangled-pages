---
title: Entangled
subtitle: literate programming for the new millennium
footer: "[![](img/escience_white.png){style='height: 20pt'}](https://esciencecenter.nl/)"
license:  "[Apache 2](https://www.apache.org/licenses/LICENSE-2.0)"
github: "https://github.com/entangled/entangled/"
---

<div class="container-fluid"><div class="row">
:::: {#synopsis}
- Create **live documents** in Markdown
- Program in **any language** you like
- Use your **favourite editor**
- Works well with **version control**
- Powered by **Pandoc**
::::

> **Literate programming** [/ˈlɪtəɹət ˈpɹəʊɡɹæmɪŋ/]{.phonetic} (computing) Literate programming is a programming paradigm introduced by Donald Knuth in which a program is given as an explanation of the program logic in a natural language, such as English, interspersed with snippets of macros and traditional source code, from which a compilable source code can be generated. [Wikipedia](https://en.wikipedia.org/wiki/Literate_programming)

</div></div>

# News

- 2020/05/29 --- Version 1.0 of Entangled is released!
- 2020/05/29 --- Version 0.6.1 of [Entangled filters](https://entangled.github.io/filters) is released.
- 2020/05/28 --- New [examples repository](https://entangled.github.io/examples).

# Get started {#section-markdown}

> "A critical aspect of a programming language is the means it provides
for using names to refer to computational objects." [Abelson, Sussman & Sussman - SICP](https://mitpress.mit.edu/sites/default/files/sicp/index.html)

#### Name your code
::: {.example}
:::: {.given-input}
~~~markdown
 The square of the hypothenuse is the sum
 of the two right-angled sides squared:
 $$a^2 + b^2 = c^2$$

 ``` {.python #pythagoras}
 def vector_length(x, y):
     return sqrt(x**2 + y**2)
 ```
~~~
::::
:::: {.generated-output}
The square of the hypothenuse is the sum of the two right-angled sides squared:
$$a^2 + b^2 = c^2$$

``` {.python #pythagoras}
def vector_length(x, y):
    return sqrt(x**2 + y**2)
```
::::
:::

> "Let us change our traditional attitude to the construction of programs:
> Instead of imagining that our main task is to instruct a computer what to do,
> let us concentrate rather on explaining to human beings what we want a
> computer to do." [Knuth - Literate Programming](http://www.literateprogramming.com/knuthweb.pdf)

#### Compose your program
::: {.example}
:::: {.given-input}
~~~markdown
 To count the words in a sentence, first
 split the sentence into words, then
 count the number of words in the list.

 ``` {.python #word-count}
 def word_count(sentence):
     <<split-into-words>>
     <<count-words>>
     return count
 ```

 The default arguments to the `.split`
 method split on any white space.

 ``` {.python #split-into-words}
 words = sentence.split()
 ```

 Counting is done with the `length`
 function.

 ``` {.python #count-words}
 count = len(words)
 ```
~~~
::::
:::: {.generated-output}
To count the words in a sentence, first split
the sentence into words, then count the number
of words in the list.

``` {.python #word-count}
def word_count(sentence):
    <<split-into-words>>
    <<count-words>>
    return count
```

The default arguments to the `.split` method
split on any white space.

``` {.python #split-into-words}
words = sentence.split()
```

Counting is done with the `len` function.

``` {.python #count-words}
count = len(words)
```
::::
:::

> “Talk is cheap. Show me the code.” [Linus Torvalds]()

#### Test your documentation
::: {.example}
:::: {.given-input}
~~~markdown
 Counting words, the zero-case:

 ``` {.python .eval #word-count}
 word_count("")
 ```

 And a small sentence:

 ``` {.python .doctest #word-count}
 word_count("Hebban olla uogala")
 ---
 4
 ```
~~~
::::
:::: {.generated-output}
Counting words, the zero-case:

``` {.python .eval #word-count}
word_count("")
```

And a small sentence:

``` {.python .doctest #word-count}
word_count("Hebban olla uogala")
---
4
```
::::
:::

## Read more

- [Examples of literate programs in Entangled](https://entangled.github.io/examples)
- [Setting up a Literate Code project](tutorial.html)
- [Use the Bootstrap 4 template](https://entangled.github.io/bootstrap)
<!-- - [Code Evaluation and Documentation Testing](eval-and-doctest.html) -->

# Entangled {#section-entangled}

Entangled makes literate programming **easier**. It keeps the markdown and program source in sync. This makes it more convenient to extend and debug your literate code.

### Installing Entangled
Entangled is written in Haskell, and can be built on Linux, MacOS and Windows. Currently the best way to install, is to [git clone https://github.com/entangled/entangled](https://github.com/entangled/entangled), and build with GHC &ge; 8.6 using Cabal 3.0. Most GNU/Linux distributions ship an older version of Haskell. The easiest way to install a newer version is through [GHCUp](https://www.haskell.org/ghcup/).

We are working on better deployment options that don't depend on compiling from source. If you are hesitant to go through the trouble of installing Haskell, there is a Python module that will let you do most of the things Entangled can do, except the live-updating reverse tangle thing.

## Pandoc filters

We have created a set of Python based Pandoc filters that can:

- **Tangle** your code
- Add **name tags** to rendered output
- Run **documentation tests** through Jupyter

The Python filters act as prototyping platform for features that will be included with Entangled. It is easy to install and has almost no dependencies outside of Pandoc and a recent version of Python (&ge; 3.7). This also makes the Python filters very easy to setup on automated builds, like Github Actions.

Install these filters using:

        pip install entangled-filters

More information on these Pandoc filters: [https://github.com/entangled/filters](https://github.com/entangled/filters)

# External Links {#section-links}

### Blogs

- [Why all you'll ever need is Markdown](https://blog.esciencecenter.nl/why-all-youll-ever-need-is-markdown-dc604f0ab309) --- Introduction to Pandoc, and Pandoc filters.
- [Entangled, a bi-directional Literate Programming tool](https://blog.esciencecenter.nl/entangled-1744448f4b9f) --- Presenting Entangled, a tool for pain free literate programming.

### Literate Books
These are some awesome books written with a literate philosophy in mind.

``` {.dhall .bootstrap-card-deck}
let Card = ./schema/Card.dhall
let Location = < Top | Right | Bottom | Left >

in [ Card :: { title = "Pharr, Jakob & Humphreys - Physically Based Rendering"
             , text =
                ''
                Explains physically realistic 3D rendering, while implementing the same
                techniques in C++. This book is so amazing, it actually won an Acadamy
                Award for technical achievement. The book uses the same *noweb*
                notation for code block references we do.
                ''
             , link = Some { href = "https://www.pbrt.org/"
                           , content = "PBRT" }
             , image = Some "img/pbrt.png"
             , imageLocation = Location.Left
             }
   ]
```

``` {.dhall .bootstrap-card-deck}
let Card = ./schema/Card.dhall
let Location = < Top | Right | Bottom | Left >

in [ Card :: { title = "Sussman & Wisdom - Structure and Interpretation of Classical Mechanics"
             , text =
                ''
                Does not use *noweb*, but subscribes to the many founding
                principles of literate programming. This is a text book on classical mechanics
                and specifically the Lagrangian and Hamiltonian discriptions of physics.
                ''
             , link = Some { href = "https://mitpress.mit.edu/books/structure-and-interpretation-classical-mechanics-second-edition"
                           , content = "SICM" }
             , image = Some "img/sicm.jpg"
             , imageLocation = Location.Left
             }
   ]
```

``` {.dhall .bootstrap-card-deck}
let Card = ./schema/Card.dhall
let Location = < Top | Right | Bottom | Left >

in [ Card :: { title = "Hudak & Quick - The Haskell School of Music"
             , text =   
                ''
                From signals to symphonies, this book fuses the authors' passion for music and the Haskell programming language.
                ''
             , link = Some { href = "http://euterpea.com/haskell-school-of-music/"
                           , content = "HSOM" }
             , image = Some "img/hsom.jpg"
             , imageLocation = Location.Left
             }
   ]
```

### Pandoc filters

- [Knitty](https://github.com/kiwi0fruit/knitty) --- Expands code-cells through a Jupyter interface. Uses Panflute. 
- [pandocsql](https://github.com/alexpdp7/pandocsql) --- Inserts tables in your markdown into an Sqlite database, and run queries that appear as tables in the output. Uses Panflute.

### Dev tools

- [Panflute](https://github.com/sergiocorreia/panflute) --- A "Pythonic" interface for creating Pandoc filters.

