Dataviewtypes are linear analogues of datatypes. As such, their memory must be managed explicitly, which typically entails creating a free function for each dataviewtype introduced. Due to potential complexity in type checking and proofs (as well as it being a concrete type) it is advised to make use of an [[absviewtype|absviewtype]] provide an interface for dataviewtypes.

## Folding
An important notion in dealing with dataviewtypes is being able to access the arguments of constructors. The implications differ if we want to use the arguments as l-values or just as r-values. For instance, take the following example:

```ocaml
datavtype dvt =
  | dvt0 of ()
  | dvt2 of (dvt,dvt)

fun foo (x: !dvt): void =
  case+ x of
  | dvt0 () => ()
  | dvt2 (x1, x2) => ()        // x1 and x2 are values
  | @dvt2 (x1, x2) => fold@(x) // x1 and x2 are l-values
```

Basically, you need to put @ in front of a linear constructor if you want to
use the arguments of the constructor as l-values. Why l-values? Because
an l-value allows its content to be modified. Note that explicit folding (fold@)
is needed if @ is used.

### A more complex example ###

This example is primarily used to build on the above while introducing a higher degree of nesting, and is based on an example from the ATS1 wiki (warning, [external link](https://sourceforge.net/p/ats-lang/wiki/dataviewtype/)). Also note that this example doesn't explicitly mention the difference
between the l-values and r-values in the comments, since the difference wasn't accessible in ATS1:

```ocaml
dataviewtype dvt =
    | dvt_0 of ()
    | dvt_1 of (dvt)
    | dvt_2 of (dvt,dvt)
(*
                                                       (a)ccessible/usable
                                                       (u)nfolded
                                                       (f)olded
                                                       (n)o view available
                                                       (-) not in scope
                                                          d0   d1   d11  d12 d121
                                                          ----------------------- *)
fun use_dvt(d0: !dvt):void = case+ d0 of               (* a    -    -    -   -    *)
  | @dvt_1 (d1 as dvt_2(d11,d12) ) => let              (* u    a    a    a   -    *)
    val () = case+ (d11,d12) of                        (*                         *)
      | (@dvt_0 (), @dvt_1 (d121) ) => let             (* u    a    u    u   a    *)
        prval () = fold@ d11 and () = fold@ d12        (* u    a    af   af  n    *)
        in () end                                      
      | (_,_) => ()                                    
    prval () = fold@ d0                                (* af   n    n    n   -    *)
    in () end                                          (* d0   d1   d2  d11  d12  *)
                                                       (*------------------------ *)
  | @dvt_2 (d1,d2) =>                                  (* u    a    a             *)
    (case+ d1 of                                       (*                         *)
      | @dvt_2 (d11,d12) => let                        (* u    u    a   a    a    *)
        prval () = fold@ d1                            (* u    af   a   n    n    *)
        prval () = fold@ d0                            (* af   n    n   n    n    *)
        in () end
      | _ => fold@ d0
    )
  | _ =>  ()
```

### Suggestions

It may be recommended (not required), to avoid systematically running head‑first to using `dataviewtype` / linear‑type, and to start a type as a `datatype` instead, which may or may not be turned into a `dataviewtype`, later. Similar comments applies to `abstype` and `absviewtype`. See this thread on *ats-lang-users* for a talk and big line rationales on this matter: [Rust lang memory management](https://groups.google.com/forum/#!topic/ats-lang-users/a17ftxArgIw).

You may use `datavtype` as a shorter substitute keyword for `dataviewtype` and `absvtype` as a shorter substitute keyword for `absviewtype`.