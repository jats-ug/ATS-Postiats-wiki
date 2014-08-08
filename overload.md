# Overloading basics

Overloading of functions is accomplished with the `overload` and `with` keywords.
In the simplest case we introduce an alphanumeric symbol using `symintr`,
then overload a function with this symbol. For instance, a standard
way of doing this is as follows:

```
symintr foo

fun foo1(x: atype): btype
overload foo with foo1
```

## Overloading precedence
If the appropriate function cannot be resolved based on type, a precedence
mechanism can be specified by using the `of` keyword followed by an integer. 
Of course, one may want to think carefully
about using overloading in this way, since it could be easy to forget
exactly which function is being used in practice; when in doubt, use the
actual function name when calling the function. Building on the 
previous example:

```
symintr foo

fun foo1(x: atype): btype
overload foo with foo1 of 10

fun foo2(x: atype): btype
overload foo with foo2 of 20
```

A lower number after `of` signifies a higher priority, so all else being equal, foo1 will be used
if we have a call like foo(atype).

# Caveats

## Overloading doesn't work with indexed types

Insert simplified version of failed example:
https://groups.google.com/forum/?utm_medium=email&utm_source=footer#!msg/ats-lang-users/Y1PxLL-9jfU/kyjkxB0wwPkJ