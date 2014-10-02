## When not to attempt clever code optimization ##

- A `macdef` in ATS2 can involve type. Use macros only in cases where using functions would be inconvenient. [Using macros probably does not make your code run more quickly][1], since `gcc -O2` already inlines functions very aggressively.

  [1]: https://groups.google.com/d/msg/ats-lang-users/Ql64LA9Wi88/fwrR7kJ3Ww0J

- Making use of the knowledge that separate val declarations within the same scope technically denote different vals on the stack should not preclude one from using a natural style. For instance:

~~~ocaml
    val x = 5
    val x = 7
~~~

here no extra space is allocated for the second 'x' due to constant propagation. It is in generally unlikely that such a coding style would incur any penalty.

## Optimization tips ##

- Instead of freeing an instance of a linear type and immediately creating and returning a new one with the same value in a case expression, like this

        case+ x of
        | ~GRgenes (genes) => GRgenes (genes)

    do this

        case+ x of
        | GRgenes _ => (fold@ x; x)

    because `@fold` is compiled into a "noop".



- Remove anonymous closure definitions from function calls when possible, to avoid having them created each time the loop is called. For instance, a simple string comparison function can be created like so:

        val cmp_str = lam(x:string,y:string):int =<cloref> compare (x, y)


## Making Lean Code ##

When the size of your code matters, for instance, in embedded applications, consider the following:

### Exception-free-code ###

Note that using exceptions at all may cause memory leaks or require a GC, so there is already some potential for overhead due to this. If your ATS code does not make use of exceptions, then you can add the following flag when compiling the code[\[1\]][1]:

\-D_ATS_CCOMP_EXCEPTION_NONE

This will make the generated object code even more compact.

Let hello.dats be a file containing the following line:

```ocaml
implement main0 () = print "Hello, world!\n"
```

```
patscc -o hello1 hello.dats
size hello1
   text    data     bss     dec     hex filename
   3434     668      40    4142    102e hello1

patscc -D_ATS_CCOMP_EXCEPTION_NONE -o hello2 hello.dats
size hello2
   text    data     bss     dec     hex filename
   1787     512      32    2331     91b hello2
```

[1]: https://groups.google.com/d/msg/ats-lang-users/NEJDC7yY9cw/IWeK_0YRhksJ
