---
title: Entangled
subtitle: literate programming for the new millennium
---
:::: {#topbar}
[[Markdown](#section-markdown)
 [Entangled](#section-entangled)
 [Examples](#section-examples)
]{#navigation}
[[![Octocat](img/github.png) Find us on Github](https://github.com/entangled/entangled)&nbsp;
 [![Download](img/download.svg) Download enTangled](https://github.com/entangled/entangled/releases)
]{#logobar}
::::

::::: {.content}
> **Literate programming** [/ˈlɪtəɹət ˈpɹəʊɡɹæmɪŋ/]{.phonetic} (computing) Literate programming is a programming paradigm introduced by Donald Knuth in which a program is given as an explanation of the program logic in a natural language, such as English, interspersed with snippets of macros and traditional source code, from which a compilable source code can be generated. [(Wikipedia)](https://en.wikipedia.org/wiki/Literate_programming)

- Create **live documents** in Markdown
- Program in **any language** you like
- Use your **favourite editor**
- Powered by **Pandoc**

# Markdown {#section-markdown}

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

#### Compose your program
::: {.example}
:::: {.given-input}
~~~markdown
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

 Counting is done with the `length` function.

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

#### Test your documentation
::: {.example}
:::: {.given-input}
~~~markdown
 Examples of counting words, the zero-case:

 ``` {.python .doctest #test-word-count}
 word_count("")
 ---
 0
 ```

 And a small sentence:

 ``` {.python .doctest #test-word-count}
 word_count("Hebban olla uogala nestas hagunnan")
 ---
 5
 ```
~~~
::::
:::: {.generated-output}
Examples of counting words, the null-case:

``` {.python .doctest #test-word-count}
word_count("")
---
0
```

And a small sentence:

``` {.python .doctest #test-word-count}
word_count("Hebban olla uogala nestas hagunnan")
---
5
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
:::

<div style="text-align: center;">
  <span class="dot" onclick="currentSlide(1)"></span>
  <span class="dot" onclick="currentSlide(2)"></span>
  <span class="dot" onclick="currentSlide(3)"></span>
  <span class="dot" onclick="currentSlide(4)"></span>
</div>

<script src="jquery-3.3.1.slim.min.js"></script>
<script src="anim.js"></script>

# Examples {#section-examples}

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
:::::
