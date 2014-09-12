There are many different string types available in ATS2 (see some of these in `prelude/basics_sta.sats`). Which should be used?

For something relatively small, using 'strptr1' for strings is fine.

For something more complicated that requires sharing of strings, one may want to use
ref-counted strings. In ATS2, there is a type [strobjref](https://github.com/githwxi/ATS-Postiats/blob/master/libats/SATS/strobjref.sats) for reference-counted strings.

At the beginning of a project, it is usually uncertain what kind of string is needed.
An abstract type can be introduced:

```ocaml
absviewtype mystring (l:addr)
```

First, `mystring` can be implemented based on `strptr`. Later, the implementation can be easily changed,
making it based on `strobjref` or something else.

In practice, if string sharing is allowed, then memory leaks are often very difficult to prevent.
For instance, there are many leaks in graphviz (according to bug reports). ATS is very good
for stopping this kind of problems[\[1\]][1].

[1]: https://groups.google.com/d/msg/ats-lang-users/MrWe5tFnR_8/4uTj6ER67OoJ