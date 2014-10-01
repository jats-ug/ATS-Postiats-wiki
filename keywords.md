* `absprop` - introduce a named abstract proposition definition; a specialized form of `sta` [1]; see [[type]].
* `abstype` - introduce a named abstract type definition; a specialized form of `sta` [1]; see [[type]].
* `absview` - introduce a named abstract view definition; a specialized form of `sta` [1]; see [[type]].
* `absviewtype` - introduce a named abstract view type definition; a specialized form of `sta` [1]; see [[type]].
* `castfn` - a function (`fn`) that changes the type, both dynamically and statically, of its argument. The converted value is returned. When only a static `castfn` is needed, one can use the `cast` and related functions in `unsafe.sats` to save time (a common use is converting a pointer from C to some other viewtype).
* `dataprop` - introduce a named algebraic proposition definition [2]; see [[type]].
* `datatype` - introduce a named algebraic type definition [2]; see [[type]].
* `dataview` - introduce a named algebraic view definition [2]; see [[type]].
* `dataviewtype`  - introduce a named algebraic view type definition [2], a linear data‑type; see [[type]] and [[dataviewtype]].
* `datavtype`  - shorter name for `dataviewtype`; see [[dataviewtype]].
* `dynload` - declare a module initialization dependency, typically from the module defining `main`; see [[dynload]].
* `extern` - declare an entity / definition as extern; the defined item may be a macro or an element in a separate compilation unit; see [[Writing interfaces to C libraries]] and [[C interface]].
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
* `propdef` - introduce an alias / name for a proposition definition; a specialized form of `stadef` [1]; see [[type]].
* `sta` - introduce an alias / name for an abstract static definition; there are specialized form of it; see [[type]].
* `stadef` - introduce an alias / name for a concrete static definition; there are specialized form of it; see [[type]].
* `staload` - either loads a name‑space assigning it to a named prefix or opens a name‑space (anonymously, without a prefix); see [[staload]].
* `symintr` - introduce the name of a symbol (without fixity) to be overloaded (this does not introduce the overloading), with the later help of `overload` and `with`; see [[overload]].
* `typedef` - introduce an alias / name for a concrete type definition; a specialized form of `stadef` [1]; see [[type]].
* `viewdef` - introduce an alias / name for a concrete view definition; a specialized form of `stadef` [1]; see [[type]].
* `viewtypedef` - introduce an alias / name for a concrete view type definition; a specialized form of `stadef` [1]; see [[type]].
* `with` - adds an overloading to a symbol introduced with `symintr`; this tells with what it is overloaded; see [[overload]].

[1]: The latter may be substituted for the former.

[2]: Algebraic à la SML.

## See also

These are not syntactically keywords, but may informally be seen as such. Like keywords, new items can't be created (see [Creating new effects?](https://groups.google.com/forum/#!topic/ats-lang-users/L38Bzie5lsE)) and thus form a fixed set (may still vary with future ATS versions).

* [[Effects|effects]]
* [[Sorts|sort]]
