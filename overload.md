## Overloading basics

Only functions can be overloaded; this includes both polymorphic and template functions. 
Overloading of functions is accomplished with the `overload` 
and `with` keywords. We choose a string to become a symbol using `symintr`,
then overload a function with this symbol. For instance, a standard
way of doing this is as follows:

```ocaml
symintr foo

fun foo1(x: atype): btype
overload foo with foo1
```

### Overloading precedence
If the appropriate function cannot be resolved based on type, a precedence
mechanism can be specified by using the `of` keyword followed by an (non-negative? positive?) integer. 
Of course, one may want to think carefully
about using overloading in this way, since it could be easy to forget
exactly which function is being used in practice; when in doubt, use the
actual function name when calling the function. Building on the 
previous example:

```ocaml
symintr foo

fun foo1(x: atype): btype
overload foo with foo1 of 10

fun foo2(x: atype): btype
overload foo with foo2 of 20
```

A higher number after `of` signifies a higher priority, so all else being equal, foo2 will be used
if we have a call like foo(atype).

### Operator fixity

Whether an operator is infix or postfix can be declared using the  `infix`, `infixl`, `infixr`, `prefix`, and `postfix` keywords. For instance, the following changes `+` to be a postfix operator, and we can overload it with
some function of our choice, say myfun(atype).

```ocaml
postfix +
overload + with myfun
(* Now instead of doing myfun(atype) we can do: *)
val x: atype = some_val
x+
(* But we can no longer do this in the same scope: *)
val m = 3 + 5
```


### Renewing a string to be a symbol
Some strings are reserved for other purposes by default in ATS. For instance, `&&` is a macro.
However, if we do

```ocaml
symintr &&
```

We can now overload `&&` with a function of our choice. Of course, the original functionality of `&&` will no longer
work in the same scope.

### Bracket overloading

Bracket overloading uses the pair of symbols `[` and `]` to allow functions to be called using a subscripting style, where the argument to the left of `[` (and the first argument of the function being overloaded) is usually thought of as the "data object" and the arguments between `[` and `]` are thought of as somehow being an index or parameterizing the value on the left of the `[`. That is only the convention though, with array and matrix subscripting being prominent examples; in principle it could be used in other ways. 

Note the following rules:
* The last function argument **of a function returning void** may be used as an r-value in the overloaded operator expression, e.g. 
```
f(x,y) -> void
// replaced by
val _ = x[] := y
```
* If the function returns values, these may be assigned to as l-values in the overloaded operator expression, e.g.:
```
f(x,y) -> z
// replaced by
val z = x[y]
```
Here is a matrix subscripting example, which doesn't compile, but see [prelude_matrixptr.dats](../../tree/master/doc/EXAMPLE/ATSLIB/prelude_matrixptr.dats) for full code:

```ocaml

(* in prelude/SATS/matrixptr.sats *)

fun{a:t0p}
matrixptr_get_at_int
  {m,n:int}
(
  A: !matrixptr(INV(a), m, n), i: natLt (m), n: int n, j: natLt (n)
) :<> (a) // end of [matrixptr_get_at_int]

fun{a:t0p}
matrixptr_set_at_int
  {m,n:int}
(
  A: !matrixptr(INV(a), m, n), i: natLt (m), n: int n, j: natLt (n), x: a
) :<!wrt> void // end of [matrixptr_set_at_int]

overload [] with matrixptr_get_at_int
overload [] with matrixptr_set_at_int

(* in doc/EXAMPLE/ATSLIB/prelude_matrixptr.dats *)

val m = 2 and n = 5
val A = (arrayptr)$arrpsz{int}(0, 1, 2, 3, 4, 5, 6, 7, 8, 9)
val M = arrayptr2matrixptr (A, m, n)
//
val () = M[0, n, 0] :=* 2
val () = M[0, n, 1] :=* 2
//...
```

Note an interesting point here is that each use of `[]` actually employs both the get and set functions, since `[]` is overloaded by both functions. 
 
A somewhat less conventional example using nothing between `[` and `]` is [locking access to a variable](http://www.ats-lang.org/DOCUMENT/ATS2TUTORIAL/CODE/chap_brktoverld.dats). See the [ATS Tutorial](http://www.ats-lang.org/DOCUMENT/ATS2TUTORIAL/HTML/book1.html) section on *Bracket Overloading* for more information.

### Creating new symbols with macros

A combination of macros (macdefs) and fixity assignments can be used
to introduce syntactic sugar for specialized symbols. For instance,
the example below allows `^t` to be used as a postfix operator used
to take the transpose (function transp_LAgmat) of a matrix: 

```ocaml
(* ****** ****** *)
(*
   HX: a hackery of a little fun
*)
#define t 't'
infixr ^
macdef ^ (M, t) = transp_LAgmat (,(M))
//
(* ****** ****** *)
```

## Caveats

### Overloading doesn't work with indexed types

Insert simplified version of failed example:
https://groups.google.com/forum/?utm_medium=email&utm_source=footer#!msg/ats-lang-users/Y1PxLL-9jfU/kyjkxB0wwPkJ