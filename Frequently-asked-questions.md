**Why does my code typecheck but not compile?**
There could be several reasons, but please note specially the one in the [[compiler errors|compiler errors]] article referring to `share/atspre_staload.hats`. 

**Where can I find information on common pitfalls? Where can I ask newbie questions about writing ATS code?**

First, read one of the [official tutorials][1]. Second, [these ATS programming tips][2] may be helpful. Third, there is a Google group, [ats-lang-users][3] for asking any kind of question, no matter how trivial, including slightly off-topic or less general-interest issues. Fourth, some of the discussions on the [SourceForge mailing list archive][4] may also prove instructive. Fifth, for other community resources, see the [official community page][5].

For information about (the sometimes opaque) ATS error messages, see [[error messages|Error messages]] on this wiki.

If you are not highly practiced with functional programming, it may be best to learn some [Standard ML][6] before learning ATS. The aid of [SML textbook(s) or introductory ATS notes][7] may be helpful.

[1]: http://www.ats-lang.org/DOCUMENT/#ATSINTRObook
[2]: http://scg.ece.ucsb.edu/software/notes.pdf
[3]: https://groups.google.com/forum/?fromgroups#!forum/ats-lang-users
[4]: https://sourceforge.net/mailarchive/forum.php?forum_name=ats-lang-users
[5]: http://www.ats-lang.org/COMMUNITY/#
[6]: http://en.wikipedia.org/wiki/Standard_ML
[7]: http://www.cs.bu.edu/~hwxi/academic/courses/Spring13/CS320.html

**Where can I find tutorials?**

See [[tutorials|Tutorials]] on this wiki, or the [Effective ATS series][26] (also [on git][27]). Also see the answer to the previous question.


**Where can I find some code or algorithm examples?**

Several examples can be found [here][8] (ATS1).

[8]: http://www.ats-lang.org/htdocs-old/EXAMPLE/example.html

**Where can I find a reference or documentation?**

For ATS, there is an unofficial (and incomplete) reference [available][9] ([source][10]). ATS2 has [automatically generated library documentation][11]. See the [[homepage|Home]] on this wiki for links to wiki pages containing further documentation.

[9]: http://www.bluishcoder.co.nz/ats/ats-reference.pdf
[10]: https://github.com/doublec/ats-reference
[11]: http://www.ats-lang.org/LIBRARY/

**I'm getting type errors or unsolved constraints, but everything looks right. What might I be doing wrong?**

Probably many things. Dependent types involve constraints; make sure you are using the right type at every step and not accidentally mixing similar types. There are many similar types in ATS (including functions with similar types) used for dealing with slightly different situations. We recommend *avoiding heavy use of dependent types when starting out* in order to avoid finding yourself in a situation with unsolved constraints that is very difficult to resolve. However, `if` and `case` expressions likely need to be annotated with types in general.

If you use emacs, consider using [ATS Flymake][12] as a possible measure to avoid such problems in the first place.

For examples of what can go wrong and some solutions see the following examples.

  - [Example 1][13]
  - [Example 2][14]
  - [Example 3][15]

Finally, for some guidance on understanding certain errors, see [[error messages|Error messages]] on this wiki.

[12]: http://www.reddit.com/r/ATS/comments/vx4lq/ats_flymake/
[13]: https://sourceforge.net/mailarchive/forum.php?thread_name=Pine.LNX.4.64.1207201538580.21676%40csa2.bu.edu&forum_name=ats-lang-users
[14]: https://groups.google.com/forum/?fromgroups=#!topic/ats-lang-users/bnROVnWcFMU
[15]: https://groups.google.com/forum/?fromgroups=#!topic/ats-lang-users/oFuXRr4K8ts

**Why did I get a segmentation fault?**

You probably have an unintended infinite recursion; these are generally easy to find. For more information, see [[loop|Loop]]s.

If you are doing something unsafe with memory, though, there are other possibilities. For more information, see [[memory leaks|Memory leaks]].

**I have two different types being used together in the same data structure, and they typecheck! Is this a bug?**

After perhaps being exposed to the rigor of dependent types, one may occasionally be surprised: but the short answer is it probably isn't a bug. [Here][16] is an example where `list0` will accept multiple values, each with a distinct type, as inputs (for example, `string`s, `float`s, or `int`s). [Here][17] is an example with templates. The notion has to do with ["subtypes"][18], and specifically, how ATS defines subtypes. This should not be a problem in ATS2, and is one of the [major reasons for ATS2][19].

[16]: http://www.ats-lang.org/DOCUMENT/INTPROGINATS/HTML/x1099.html
[17]: https://sourceforge.net/mailarchive/forum.php?thread_name=Pine.LNX.4.64.1204041554160.22282%40csa2.bu.edu&forum_name=ats-lang-users
[18]: http://en.wikipedia.org/wiki/Covariance_and_contravariance_(computer_science)
[19]: https://sourceforge.net/mailarchive/forum.php?thread_name=727FCEF6-16CE-4249-97B6-750CBB2B2371%40users.sourceforge.net&forum_name=ats-lang-users

**What are dependent types?**

A [dependent type][20] is a type that depends on a value. As a simple example in ATS, `int (5)` is a type such that all integers belonging to it are equal to 5 (so it is in fact a singleton type). 

[20]: http://en.wikipedia.org/wiki/Dependent_type

**What are linear types?**

Linear types make use of [linear logic][21]. The notion of linear types may be explained as viewing variables as resources that are consumed by expressions, which allows for static resource tracking. For example, if you consider the expression `(a or b)`, you've produced a new expression but you've destroyed `a` and `b`. This is useful for dealing with memory allocation safely and efficiently, for instance. For more information, see the [ATS book][22], the [Wikipedia article on linear types][23], or [[linear types|Linear types]] on this wiki.

[21]: http://en.wikipedia.org/wiki/Linear_logic
[22]: http://www.ats-lang.org/DOCUMENT/INTPROGINATS/HTML/c3217.html
[23]: http://en.wikipedia.org/wiki/Substructural_type_system#Linear_type_systems

**Is there a Windows version of ATS?**

Not for the near future, at least. However, you can install ATS on top of [Cygwin][24] using the same build instructions as for other platforms.

You can also try ATS2 using [this experimental online tool][25], or try using a virtual machine (see [[building and installing|Building and installing]] ATS).

[24]: http://www.cygwin.com/
[25]: http://xrats.illtyped.com/code/patsopt



[26]: http://www.ats-lang.org/EXAMPLE/EFFECTIVATS/
[27]: https://github.com/githwxi/ATS-Postiats/tree/master/doc/EXAMPLE/EFFECTIVATS