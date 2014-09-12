This page lists built-in operators for ATS.

  - `!=` - "Not equal to" (float/double/int). Also the same as <>, but preferred since it is easier to read for most and does not share the same string as the function effect <>.
  - `<>` - "Not equal to" (float/double/int). Also the same as !=, but not recommended in general since it is less common than != in most programming languages and does not share the same string as the function effect <>.
  - `=>` - Similar to `=`, but used to define the body of a lambda function or a case expression.
  - `=>>` - Similar to `=>`, but indicates to the typechecker that this clause needs to be typechecked under the sequentiality assumption that the given value that matches it does not match the pattern guards associated with any previous clauses. For more information, see [Sequentiality of Pattern Matching][1] or the [forums][2].
  - `=/=>` - Similar to `=>>`  but indicates to the typechecker that the proof following `=/=>` must prove falsehood. During compilation (after typechecking), the clause is removed as it can never be chosen at run-time [because matching v against yields falsehood][3].
  - `=/=>>` - combines the features of `=/=>` and `=>>`.
  - `#[ ... ]` - Allows static variables present in a function return type to be used in the statics of the function's arguments. For example, if we want `b` from the return type to be in the scope of the statics in the arguments, (that is, `b` in `opt (a,b)`):

```ocaml
fun{a:t@ype}
linset_choose (xs: !set a, x0: &a? >> opt (a, b)) : #[b:bool] bool (b)
```
  - `#[ ...  | ... ]` - Provides static values (witnesses) to the type checker when they are missing or cannot be inferred. See [typechecking errors ](https://github.com/githwxi/ATS-Postiats/wiki/typechecking-errors#supplying-static-values-to-the-typechecker) for examples.
  - `!` - This can mean two things. First, if used in a function signature, it means the following variable name is to be accessed with call-by-value. When a value of the (view)type VT is passed as a call-by-value parameter, the data part of the value stays the same but the view part may change.
Elsewhere, it means to dereferences pointer. Given a pointer `p` of the type `ptr(L)` for some `L`, `!p` yields the value stored at the memory location `L`. The typechecker first searches for a proof of the view `T@L` for some `T` among all the currently available proofs when typechecking `!p`; if such a proof `pf` is found, then `!p` dereferences the pointer.
  - `&` - In a function signature, this means call-by-reference.
  - `:=` - Assign new value to left-value. Examples of left-value are: variables, dereferenced pointers, dreferenced references, field selection, array subscripting, named linear proof values, etc.

[1]: http://www.ats-lang.org/DOCUMENT/INTPROGINATS/HTML/x2683.html
[2]: https://groups.google.com/d/msg/ats-lang-users/g3A2fzeKM3A/2UYOjNLVZ5sJ
[3]: https://groups.google.com/d/msg/ats-lang-users/NpQZuB7W9PU/5pwjoDi4oj0J