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

A lower number after `of` signifies a higher priority, so all else being equal, foo1 will be used
if we have a call like foo(atype).

### Operator fixity

Whether an operator is infix or postfix can be declared using the  `infix`, `infixl`, `infixr`, `prefix`, and `postfix` keywords. For instance, the following changes `+` to be a postfix operator, and we can overload it with
some function of our choice, say myfun(atype).

```ocaml
postfix +
overload + with myfun
// Now instead of doing myfun(atype) we can do:
val x: atype = some_val
x+
// But we can no longer do this in the same scope:
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


### Creating new symbols with macros

A combination of macros (macdefs) and fixity assignments can be used
to introduce syntactic sugar for specialized symbols. For instance,
the example below allows `^t` to be used as a postfix operator used
to take the transpose (function transp_LAgmat) of a matrix: 

```ocaml
(* ****** ****** *)
//
// HX: a hackery of a little fun
//
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