The design of ATS helps the programmer to create code without memory leaks. Still, there are a few ways to create leaky code.

  1. Using bad C code or other non-ATS code that is not memory-safe.
  2. Raising exceptions (may, not always)
  3. In ATS versions before ATS 2, the code

```ocaml
prval () = foo_free(afoo)
```
    
can cause a leak. Instead, use

```ocaml
val () = foo_free(afoo)
```

Here are some strategies for creating memory-safe code in ATS.

> Fill me in!