**INV**

INV (for invariant) is essentially marker for typechecking [\[1\]][1]. For instance, say you have a function foo
declared as follows:

```ocaml
fun{a:t@ype} foo (xs: list0 (a)): void
```

Assume that `mylst` is of the type `list0 (T)` for some `T`. When typechecking `foo(mylst)`, the typechecker will expand the expression as follows by picking a placeholder `T1`:

```ocaml
foo<T1>(mylst)
```

where `T <= T1` is assumed, so that mylst can contain any subtype--in the [covariant](http://en.wikipedia.org/wiki/Covariance_and_contravariance_(computer_science)#Formal_definition) sense--of T1 [\[2\]][2]. Say that `foo2` is declared as follows:

```ocaml
fun{a:t@ype} foo2 (xs: list0 (INV(a))): void
```

When `foo2(mylst)` is typechecked, the typechecker simply expands the expression to the following one:

```ocaml
foo2<T>(mylst)
```

preventing types other than precisely `T` to be a part of `mylst`.

[1]: https://groups.google.com/forum/#!topic/ats-lang-users/ptwztS9IHWg
[2]: http://sourceforge.net/mailarchive/forum.php?thread_name=alpine.LRH.2.02.1302120729160.29395%40csa2.bu.edu&forum_name=ats-lang-users