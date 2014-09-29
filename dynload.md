The sole purpose of dynload is for doing initialization. For instance, val- and var-bindings introduced at the top-level need to be initialized properly.

Say a module named 'bar.dats' exists and contains the following code:

```ocaml
val x = fact(5)
```

where 'fact' is a factorial function, defined elsewhere.

Now, the value of [x] must be initialized and it is done in the dynload function (i.e., the initilization function) associated with module 'bar.dats'. Say in a file named 'foo.dats', we have the following line:

```ocaml
dynload "bar.dats"
```

This line gets compiled to a call to the initialization function
associated with 'bar.dats'. Without this line, a link-time error message
of the form "..._dynload_flag is undefined" is to be reported.

If you don't want the initialization function (generated automatically by the 
compiler for any .dats file) for 'bar.dats' to be called, then please add the 
following line in 'bar.dats':

```ocaml
#define ATS_DYNLOADFLAG 0
```
Please do this with caution.

Normally, 'dynload' lines should only occur in the file that contains the
implementation of the 'main' function [\[1\]][1]

[1]: https://groups.google.com/d/msg/ats-lang-users/jqFEAf1drXc/uv5x_rx3aMEJ
