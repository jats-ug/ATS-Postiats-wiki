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

### See also

[[Internal Types|Internal-types]], to understand the `S2Eapp`, `S2Ecst`, etc, which often appears in error messages.

[1]: https://sourceforge.net/p/ats-lang/wiki/Error%20messages/

## Constraint-solver limitations

### Supplying static values to the typechecker
Should generate `unsolved constraint: C3NSTRprop` messages.

In some rare cases, it may be necessary to supply a static value (if a singleton type will do) to the typechecker, as the constraint solver may not be able to infer the constraints. For instance, here is an example below where the typechecker can't solve for an integer `x` such that `2x = 2` ([Fourier-Motzkin elimination](https://en.wikipedia.org/wiki/Fourier%E2%80%93Motzkin_elimination) is for linear inequalities, so this integer equality proves to be more difficult and is currently unsupported by the solver). We can get around this by suggesting that a valid value for static `x` in the `DubInt` type below, when `2x = 2`, is `1`, and we supply `1` explicitly:

```ocaml
typedef Int = [x:int] int(x)
typedef IntGT0 = [x:nat] int(x)
typedef DubInt = [x:int] int(2*x)

fun
fun1 (x: Int): void = ()

fun
funGT0 (x: IntGT0): void = ()

fun
dubx(x: DubInt): void = ()

implement main0 () = {
val x1:int(1) = 1
val x2:int(2) = 2

(* These are fine *)
val () = fun1(x1)
val () = funGT0(x1)

(*
This would produce an unsolved constraint due to
equality constraint:

val () = dubx(x2)

Instead we can do:  *)

val () = dubx(#[ 1 | x2])
}
```

Another case may happen when we aren't able to supply the type implicitly since no constraints on the type are generated. In such a case, supplying a static value will work:

```ocaml
datatype
either_t0ype_bool_type
(
  a:t@ype+, b:t@ype+, bool

) =
  | Left (a, b, true) of (a)
  | Right (a, b, false) of (b)

stadef
either = either_t0ype_bool_type
typedef
either (a:t0p, b:t0p) = [c:bool] either(a, b, c)


fn{
a,b:t0p
} either_left (a:a):<> either(a, b, true) = Left(a)

fn{
a,b:t0p
} either_right (b:b):<> either(a, b, false) = Right(b)


fun do_either(x : int)
  : [n:nat; m:nat] either (int n, int m) =
  (* This would fail to typecheck due to unknown static values (i.e. types) 
     for 'b' and 'a' in either(_,b,_) and either(a,_,_) respectively:
  if x > 0 then either_left(0) else either_right(1)                   
  
  Instead we can do:                                                    *)
  if x > 0 then #[0,1 | either_left(0)] else #[0,1 | either_right(1)]

implement main0() = ignoret(do_either(~1))
``` 

##Template-related errors##


- The template is expected to be fully applied but it is not.

This error will pop up from leaving out a template argument in some form, and it is often the case (especially for beginners), that they've put the a template argument on the wrong side of the function name.