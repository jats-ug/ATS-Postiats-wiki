## Sample code

### main.dats

```ocaml
#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"

extern fun c_func_kick (int): int = "mac#"
extern fun ats_func_plus1: (int) -> int = "ext#"

implement ats_func_plus1 (a) = a + 1

implement main0 () = {
  val () = println! (c_func_kick 9)
}
```

### c_func.c

```c
extern int ats_func_plus1(int);

int c_func_kick(int a) {
    ats_func_plus1(a);
}
```

## Build and run it

```
$ patscc main.dats c_func.c -o main
$ ./main
```

## More detail

See ["Introduction to Programming in ATS: Interaction with C"](http://www.ats-lang.org/DOCUMENT/INT2PROGINATS/HTML/c1995.html).
