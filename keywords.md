* `castfn` - a function (`fn`) that changes the type, both dynamically and statically, of its argument. The converted value is returned. When only a static `castfn` is needed, one can use the `cast` and related functions in `unsafe.sats` to save time (a common use is converting a pointer from C to some other viewtype).
* `datavtype`  - introduce a linear data‑type; see [[dataviewtype]].
* `dataviewtype`  - introduce a linear data‑type; see [[dataviewtype]].
* `dynload` - declare a module initialization dependency, typically from the module defining `main`; see [[dynload]].
* `fn` - non-recursive function (`fun`). Used in place of `fun` for optimization purposes (is this true?) and as well as to check against the possibility of an accidental infinite loop.
* `fun` - a function that can be recursive.
* `infix` - like `symintr`, but with fixity; see [[overload]].
* `infixr` - like `symintr`, but with fixity; see [[overload]].
* `infixl` - like `symintr`, but with fixity; see [[overload]].
* `implement` - used to implement a function that has been defined using `fun` or `fn`
* `of` - has several purposes. Most commonly, it is used as a type specifier in an algebraic constructor (e.g. in a `datatype`). It also can specify the type in some other contexts such as specifying what the ATS type is for an external type (`$extype`; see [[C interface|C interface]]). Finally, it can denote operator overloading precedence (see [[overload|overload#overloading-precedence]]).
* `overload` - overloads a symbol previously introduced with `symintr`; this tells what is overloaded; see [[overload]].
* `prefix` - like `symintr`, but with fixity; see [[overload]].
* `postfix` - like `symintr`, but with fixity; see [[overload]].
* `staload` - either loads a name‑space assigning it to a named prefix or opens a name‑space (anonymously, without a prefix); see [[staload]].
* `symintr` - introduce the name of a symbol (without fixity) to be overloaded (this does not introduce the overloading), with the later help of `overload` and `with`; see [[overload]].
* `with` - adds an overloading to a symbol introduced with `symintr`; this tells with what it is overloaded; see [[overload]].

## See also

These are not syntactically keywords, but may informally be seen as such. Like keywords, new items can't be created (see [Creating new effects?](https://groups.google.com/forum/#!topic/ats-lang-users/L38Bzie5lsE)) and thus form a fixed set (may still vary with future ATS versions).

* [[Effects|effects]]
* [[Sorts|sort]]
