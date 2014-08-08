ATS has a number of data structures found in both functional and imperative programming. We summarize them here.

  - **Maps (dictionaries).** Several implementations of maps are available, with nearly identical interfaces in most cases. Look for linmap or funmap. These are based on [AVL trees](http://en.wikipedia.org/wiki/AVL_tree) or [red-black trees](http://en.wikipedia.org/wiki/Red%E2%80%93black_tree). Use funmap variants unless you wish to employ linear types.
  - **Strings (C strings).** ATS provides a safe mechanism to use the infamous but efficient C string.
  - **Arrays.**
  - **Sets.** ATS includes linear sets as `linset` and functional sets as `funset`. These are based on [AVL trees][1], [red-black trees][2], or ordered-lists.

    Integer multisets are also available. The book **Introduction to Programming in ATS** includes a [discussion and implementation of red-black trees][3] useful for sets.

  - **Regular expressions.**  ATS provides an interface to PCRE, a library for Perl-style regular expressions.

[1]: http://en.wikipedia.org/wiki/AVL_tree
[2]: http://en.wikipedia.org/wiki/Red%E2%80%93black_tree
[3]: http://www.ats-lang.org/DOCUMENT/INTPROGINATS/HTML/x2786.html
