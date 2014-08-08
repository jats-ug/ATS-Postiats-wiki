Functional Programming (FP) style in ATS.
-----------------------------------------------------------


**General Advice**

**(Insert sagely advice in this paragraph)** As with many things, optimal learning can be achieved by different people in different ways. A suggestion for functional programming in general, to those who have experience in imperative programming, is to read examples, understand examples, and ***implement examples***. Much like math or writing literature, most people need practice and experience to really become effective. Abstraction is an important mechanism in making good style (and good code) possible. This [code example for a calculator](http://www.cs.bu.edu/~hwxi/academic/courses/CS320/Spring13/code/calculator/), while not exactly a tutorial, demonstrates these principles. [Discussion on the calculator example is located here](https://groups.google.com/forum/?fromgroups=#!topic/ats-lang-users/ad5S6SY0I0E).


(Any good journals or sites accessible to a beginner that aren't ATS specific but still applicable for an ATS beginner?)

There are many examples in the [ATS2 Book](http://www.ats-lang.org/DOCUMENT/INT2PROGINATS/HTML/book1.html), and also [some examples listed separately](http://www.ats-lang.org/htdocs-old/EXAMPLE/example.html).


**Some examples of poor versus good implementations in ATS:**

[A simple tokenizer.](https://groups.google.com/forum/?fromgroups#!topic/ats-lang-users/SeVHXg8jcxA)

[How **NOT** to use references.](http://www.ats-lang.org/DOCUMENT/INTPROGINATS/HTML/x1357.html)

**Using case with conditionals.**
An alternative to using a string of if-then-else expressions is to use a case-when expression. This is more powerful and elegant than if-then-else because pattern matching can also be integrated, and the syntax is more compact. For a simple example emulating switch-case without pattern matching, see the following:

```ocaml
(*
We are testing x for several possible values.
We use case+ of 0, but we could use "of anything"
since the anything doesn't matter in this case.
*)
case+ 0 of
| _ when x = 1 || x = 3 => print("An odd int < 5\n")
| _ when x = 2 || x = 4 => print("An even int < 5\n")
| _ => print("Not 1, 2, 3, or 4.\n")
```

**val vs var**
Some very good material on how to deal with val and var bindings, which come from functional and imperative programming respectively, can be found on the [old ATS site](http://www.ats-lang.org/htdocs-old/TUTORIAL/contents/val-and-var.html).

Additionally, some static assignment features supported by val [are currently unsupported by var](https://groups.google.com/d/msg/ats-lang-users/V7Mr-NZcB5E/mbaTioLJPv0J), but in principle could be added. As a work around, intermediate vals can be used.


**Loops**

Examples abound on using tail-recursive functions as loops in place of while and for loops to achieve the same effect in a functional programming style. Often, it is useful to declare a function as being &lt;cloref&gt; to allow the function to use variables defined outside of its body or argument list; &lt;cloref&gt;  means "the function is a peristent closure that requires the garbage collector to be freed". [Apparently](https://groups.google.com/d/msg/ats-lang-users/2LtZdgNO9W8/H_PjUDG1uUUJ), this does not mean that a closure is actually created each time a &lt;cloref&gt; function is called, as it is heap allocated. See [this tutorial](http://bluishcoder.co.nz/2010/06/20/closures-in-ats.html) for further details.


Style with dependent types.
---------------------------
Dependent types are often difficult to use, and should be avoided when possible on the first pass of writing an implementation. Their use can overly complicate program implementation by a very large margin; so a non-dependent "program-first program verification" approach, possibly with linear types, is encouraged. 

An example of this is a [[sort|sort]] for doubles and floats, which no longer exists in ATS due to its propensity for complicating code.

The same caution and program-first program verification approach can likely be applied to writing proof functions in ATS. 


Style with linear types.
---------------------------
Linear types are generally easy to use, with a few exceptions, such as [[dataviewtype|dataviewtype]]s. No knowledge of linear logic formalisms is necessary for using linear types in ATS. Perhaps the main issue for beginners with linear types, or at least linear types in ATS, will be getting used to a somewhat large body of syntactical features; many of these share some overlap in their conceptual usage but operate on different resources. This is somewhat in contrast to dependent types, where the syntax is relatively easy, but keeping track of the logic in one's mind can become quite a burden. This makes using dependent type all too easy to get one in to trouble with the typechecker (see above).

An [example of using linear types with unlimited precision integers](https://groups.google.com/forum/?fromgroups=#!topic/ats-lang-users/Cdk-_gbeVfE) (using [GMP](http://gmplib.org/)) is available, which should be useful for beginners to learn linear types.