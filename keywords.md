* `castfn` - a function (`fn`) that changes the type, both dynamically and statically, of its argument. The converted value is returned. When only a static `castfn` is needed, one can use the `cast` and related functions in `unsafe.sats` to save time (a common use is converting a pointer from C to some other viewtype).
* `datavtype`  - introduce a linear data‑type; see [[dataviewtype]].
* `dataviewtype`  - introduce a linear data‑type; see [[dataviewtype]].
* `dynload` - declare a module initialization dependency, typically from the module defining `main`; see [[dynload]].
* `fn` - non-recursive function (`fun`). Used in place of `fun` for optimization purposes (is this true?) and as well as to check against the possibility of an accidental infinite loop.
* `fun` - a function that can be recursive.
* `implement` - used to implement a function that has been defined using `fun` or `fn`
* `of` - has several purposes. Most commonly, it is used as a type specifier in an algebraic constructor (e.g. in a `datatype`). It also can specify the type in some other contexts such as specifying what the ATS type is for an external type (`$extype`; see [[C interface|C interface]]). Finally, it can denote operator overloading precedence (see [[overload|overload#overloading-precedence]]).
* `overload` - overloads a symbol previously introduced with `symintr`; this tells what is overloaded; see [[overload]].
* `symintr` - introduce the name of a symbol to be overloaded (this does not introduce the overloading), with the later help of `overload` and `with`; see [[overload]].
* `with` - adds an overloading to a symbol introduced with `symintr`; this tells with what it is overloaded; see [[overload]].
