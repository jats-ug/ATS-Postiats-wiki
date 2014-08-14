Error messages are evolving in ATS2. There are five primary classes of error
messages: [[parsing errors|parsing errors]], [[linker errors|linker
errors]], [[runtime errors|runtime errors]], [[compiler errors|compiler
errors]], and the most common -- [[typechecking errors|typechecking
errors]]. For error messages known to have been used in the past, especially
in ATS1, please see the [old wiki][1].

----------------

Perhaps the most common error for most people new to ATS will be
[[typechecking errors|typechecking errors]]. For this reason, the
typechecking directive `$showtype` can be immensely helpful. For example, in
the following simple example:

```ocaml val x = 7 val _ = $showtype x

val y = ref<int> 7 val _ = $showtype y val _ = $showtype !y ``` we might
think !y and x should have the same type. This can be checked by the
`$showtype` output when running the typechecker:

    **SHOWTYPE**(/home/myhome/showtype_test.dats: 143(line=12, offs=19) -- 144(line=12, offs=20)): S2Eapp(S2Ecst(g1int_int_t0ype); S2Ecst(int_kind), S2Eintinf(7))
    **SHOWTYPE**(/home/myhome/showtype_test.dats: 183(line=15, offs=19) -- 184(line=15, offs=20)): S2Eapp(S2Ecst(ref_vt0ype_type); S2Eapp(S2Ecst(g0int_t0ype); S2Ecst(int_kind)))
    **SHOWTYPE**(/home/myhome/showtype_test.dats: 203(line=16, offs=19) -- 205(line=16, offs=21)): S2Eapp(S2Ecst(g0int_t0ype); S2Ecst(int_kind))


More concisely,

``` type of x: S2Eapp(S2Ecst(g1int_int_t0ype); S2Ecst(int_kind),
S2Eintinf(7))  type of y: S2Eapp(S2Ecst(ref_vt0ype_type);
S2Eapp(S2Ecst(g0int_t0ype); S2Ecst(int_kind)))  type of !y:
S2Eapp(S2Ecst(g0int_t0ype); S2Ecst(int_kind))  ```

So we can see that the assumption proved incorrect. Let's try again with a
new val, z:

```ocaml val z = ref<int(7)> 7 val _ = $showtype !z ````

```` type of !z: S2Eapp(S2Ecst(g1int_int_t0ype); S2Ecst(int_kind),
S2Eintinf(7))  ```

which shows that !z is now the same type as x. This reflects that by
default, integers have types parameterized by their values in ATS, as was
the case for x.

## See also

[[Internal Types|Internal-types]], to understand the `S2Eapp`, `S2Ecst`,
etc, which often appears in error messages.

[1]: https://sourceforge.net/p/ats-lang/wiki/Error%20messages/
