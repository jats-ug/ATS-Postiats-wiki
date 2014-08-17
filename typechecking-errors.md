## Reading error messages
Perhaps the most common error for most people new to ATS will be typechecking errors. 
For this reason, it is important first to get comfortable with the typechecking error messages by being able to read them without much difficulty. Although the error messages may appear archaic at first, there is [no easy way around it](https://groups.google.com/d/msg/ats-lang-users/-zsdyZWglRs/SUZt89SjYNcJ), and some experience will make reading the error messages a matter of course.

For instance, the following line of code

```ocaml
val () = assertloc (sum = showtype(1+2+3+4+5.0))
```

generates the following messages:

```
/tmp/abcde.dats: 357(line=27, offs=10) -- 394(line=27, offs=47): error(3): the symbol [=] cannot be resolved as no match is found.
/tmp/abcde.dats: 357(line=27, offs=10) -- 394(line=27, offs=47): error(3): [/home/hwxi/research/Postiats/git/src/pats_trans3_util.dats]: d3exp_trdn: the dynamic expression cannot be assigned the type [S2Eapp(S2Ecst(bool_bool_t0ype); S2EVar(10))].
/tmp/abcde.dats: 357(line=27, offs=10) -- 394(line=27, offs=47): error(3): mismatch of static terms (tyleq):
```

It means:

1. the overloaded operator = cannot be resolved
2. the compiler assigns a error-type (S2Eerr) to the expression: sum = showtype(1+2+3+4+5.0)
3. S2Eapp(S2Ecst(bool_bool_t0ype); S2EVar(10)) stands for bool_bool_t0ype(...)
4. assertloc expects a value of type bool_bool_t0ype(...), but a value of error-type (S2Eerr) is provided.


## $showtype demonstration
Another immensely helpful tool is the `$showtype` directive, which prints the type of a value. **When programming in ATS, one is expected to be able to tell the type
of *any* expression in his or her code. If not, then one may get lost even
if type-error messages are prettified.**  For example, in the following simple example:

```ocaml
val x = 7
val _ = $showtype x

val y = ref<int> 7
val _ = $showtype y
val _ = $showtype !y
```
we might think `!y` and `x` should have the same type. This can be checked by the `$showtype` output when running the typechecker:

    **SHOWTYPE**(/home/myhome/showtype_test.dats: 143(line=12, offs=19) -- 144(line=12, offs=20)): S2Eapp(S2Ecst(g1int_int_t0ype); S2Ecst(int_kind), S2Eintinf(7))
    **SHOWTYPE**(/home/myhome/showtype_test.dats: 183(line=15, offs=19) -- 184(line=15, offs=20)): S2Eapp(S2Ecst(ref_vt0ype_type); S2Eapp(S2Ecst(g0int_t0ype); S2Ecst(int_kind)))
    **SHOWTYPE**(/home/myhome/showtype_test.dats: 203(line=16, offs=19) -- 205(line=16, offs=21)): S2Eapp(S2Ecst(g0int_t0ype); S2Ecst(int_kind))


More concisely, 

```
type of x:  S2Eapp(S2Ecst(g1int_int_t0ype); S2Ecst(int_kind), S2Eintinf(7))
type of y:  S2Eapp(S2Ecst(ref_vt0ype_type); S2Eapp(S2Ecst(g0int_t0ype); S2Ecst(int_kind)))
type of !y: S2Eapp(S2Ecst(g0int_t0ype); S2Ecst(int_kind))
```

So we can see that the assumption proved incorrect. Let's try again with a new value, `z`:

```ocaml
val z = ref<int(7)> 7
val _ = $showtype !z
````

````
type of !z: S2Eapp(S2Ecst(g1int_int_t0ype); S2Ecst(int_kind), S2Eintinf(7))
```

which shows that `!z` is now the same type as `x`. This reflects that by default, integers have types parameterized by their values in ATS, as was the case for `x`.

## See also

[[Internal Types|Internal-types]], to understand the `S2Eapp`, `S2Ecst`, etc, which often appears in error messages.

[1]: https://sourceforge.net/p/ats-lang/wiki/Error%20messages/

##Template-related errors##


- The template is expected to be fully applied but it is not.

This error will pop up from leaving out a template argument in some form, and it is often the case (especially for beginners), that they've put the a template argument on the wrong side of the function name.