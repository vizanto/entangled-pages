---
title: Entangled
subtitle: literate programming for the new millennium
---
:::: {#topbar}
[[Get started](#section-markdown)
 [About Entangled](#section-entangled)
 [Demo Gallery](#section-examples)
 [External Links](#section-links)
]{#navigation}
[[![Octocat](img/github.png) Find us on Github](https://github.com/entangled/entangled)&nbsp;
 [![Download](img/download.svg) Download Entangled](https://github.com/entangled/entangled/releases)
]{#logobar}
::::

::::: {#content}
> **Literate programming** [/ˈlɪtəɹət ˈpɹəʊɡɹæmɪŋ/]{.phonetic} (computing) Literate programming is a programming paradigm introduced by Donald Knuth in which a program is given as an explanation of the program logic in a natural language, such as English, interspersed with snippets of macros and traditional source code, from which a compilable source code can be generated. [Wikipedia](https://en.wikipedia.org/wiki/Literate_programming)

::: {#synopsis}
- Create **live documents** in Markdown
- Program in **any language** you like
- Use your **favourite editor**
- Works well with **version control**
- Powered by **Pandoc**
:::

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

 ``` {.python .doctest #word-count}
 word_count("")
 ---
 0
 ```

 And a small sentence:

 ``` {.python .doctest #word-count}
 word_count("Hebban olla uogala")
 ---
 3
 ```
~~~
::::
:::: {.generated-output}
Counting words, the zero-case:

``` {.python .doctest #word-count}
word_count("")
---
0
```

And a small sentence:

``` {.python .doctest #word-count}
word_count("Hebban olla uogala")
---
3
```
::::
:::

# Entangled {#section-entangled}

Entangled makes literate programming **easier**. It keeps the markdown and program source in sync. This makes it more convenient to extend and debug your literate code.

::: {#slide-show}
:::: {.slide .fade}
![Write your documentation, and fire up entangled](img/01-getting-started.png){ still="img/01-getting-started.png" width="768" .anim }
::::

:::: {.slide .fade}
![Add annotated code blocks](img/02-adding-code.png){ still="img/02-adding-code.png" width="768" .anim }
::::

:::: {.slide .fade}
![Use references to grow your program](img/03-edit-code.png){ still="img/03-edit-code.png" width="768" .anim }
::::

:::: {.slide .fade}
![Fix bugs like you'd normally do](img/04-fixing-bugs.png){ still="img/04-fixing-bugs.png" width="768" .anim }
::::

<div class="nav" style="text-align:center">
<a class="prev" onclick="plusSlides(-1)">&#10094;</a>
<a class="next" onclick="plusSlides(1)">&#10095;</a>
</div>
<div style="text-align: center;">
  <span class="dot" onclick="currentSlide(1)"></span>
  <span class="dot" onclick="currentSlide(2)"></span>
  <span class="dot" onclick="currentSlide(3)"></span>
  <span class="dot" onclick="currentSlide(4)"></span>
</div>
<script src="jquery-3.3.1.slim.min.js"></script>
<script src="anim.js"></script>
:::

## Python filters

We have created a set of Python based Pandoc filters that can:

- **Tangle** your code
- Add **name tags** to rendered output
- Run **documentation tests** through Jupyter

The Python filters act as prototyping platform for features that will be included with Entangled. It is easy to install and has almost no dependencies outside of Pandoc and a recent version of Python (&ge; 3.7). This also makes the Python filters very easy to setup on automated builds, like Github Actions.

More information on these Pandoc filters: [https://github.com/entangled/filters](https://github.com/entangled/filters)

# Demo Gallery {#section-examples}

#### Hello, World!
::: {#examples-div}
:::: {.example}
![Apollo Earthrise](img/hello-world-thumb.jpg)

[Hello World in C++](https://entangled.github.io/entangled/hello-world.html): Teaches the basics of literate programming using Markdown and fenced code blocks. Also shows how to use a BibTeX file for references.
::::

#### 99 Bottles
:::: {.example}
![99 bottles thumbnail](img/99-bottles-thumb.jpg)

[99-bottles in C++](https://entangled.github.io/entangled/99-bottles.html): Over-engineered song-text generator. Teaching how to setup a basic C++ program with enTangleD, use of ArgAgg to parse command-line arguments, use of FmtLib to do string formatting and setting up a slightly non-basic Makefile.
::::

#### Slasher
:::: {.example}
![Slasher thumbnail](img/slasher-thumb.jpg)

[Slasher](https://entangled.github.io/entangled/elm-slasher.html): a browser game written in Elm. A dashing hero is zipping across the screen, only deflected by slashes and backslashes. The game works, but the source may need some more literacy in some places.
::::

#### Cosmic web
:::: {.example}
![Adhesion code thumbnail](img/adhesion-code-thumb.jpg)

[Adhesion code](https://jhidding.github.io/adhesion-code): presenting the cosmological adhesion model and its implementation in C++ and CGAL.
::::
:::

# External Links {#section-links}

## Literate Books
These are some awesome books written with a literate philosophy in mind.

### [Pharr, Jakob & Humphreys - Physically Based Rendering](https://www.pbrt.org/)
:::: {.book}
::: {.book-img}
![spheres](img/pbrt.png)
:::
::: {.book-expl}
Explains physically realistic 3D rendering, while implementing the same techniques in C++. This book is so amazing, it actually won an Acadamy Award for technical achievement. The book follows the same *noweb* notation for code block references we do.
:::
::::

### [Sussman & Wisdom - Structure and Interpretation of Classical Mechanics](https://mitpress.mit.edu/books/structure-and-interpretation-classical-mechanics-second-edition)
:::: {.book}
::: {.book-img}
![sicm](img/sicm.jpg)
:::
::: {.book-expl}
Does not use *noweb*, but subscribes to the many founding principles of literate programming. This is a text book on classical mechanics and specifically the Lagrangian and Hamiltonian discriptions of physics. The aim of translating concepts in classical mechanics to scheme code forced the authors to adopt a different notation for the underlying mathematics, because the traditional notation is too ambiguous.
:::
::::

### [Hudak & Quick - The Haskell School of Music](http://euterpea.com/haskell-school-of-music/)
:::: {.book}
::: {.book-img}
![hsom](img/hsom.jpg)
:::
::: {.book-expl}
From signals to symphonies, this book fuses the authors' passion for music and the Haskell programming language.
:::
::::

## Pandoc filters

### [Knitty](https://github.com/kiwi0fruit/knitty)
Expands code-cells through a Jupyter interface. Uses Panflute. 

### [pandocsql](https://github.com/alexpdp7/pandocsql)
Inserts tables in your markdown into an Sqlite database, and run queries that appear as tables in the output. Uses Panflute.

## Dev tools

### [Panflute](https://github.com/sergiocorreia/panflute)
A "Pythonic" interface for creating Pandoc filters.
:::::

<footer><address>2019 Johan Hidding, [![Netherlands eScience Center](img/escience_black.png)](https://esciencecenter.nl)</address></footer>
