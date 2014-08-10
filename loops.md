### Need to copy most info from here:
https://groups.google.com/forum/#!searchin/ats-lang-users/%22for$20loop%22/ats-lang-users/NfHeSJpaq78/zjys-ug5eMUJ

## For and While loops
In ATS2, it is usually encouraged to use recursive functions instead of loops (as it is in most programming languages that allow functional programming). However, there are cases where it may be desirable to have for loops or while loops. For loops in particular are useful for certain parallel programming environments, such as the [fork–join model](http://en.wikipedia.org/wiki/Fork%E2%80%93join_model), which is available in ATS2 through [OpenMP](https://github.com/githwxi/ATS-Postiats-contrib/tree/master/contrib/OpenMP). While loops naturally lend themselves towards waiting for some condition to change, but unlike the use-case mentioned above using for loops, this construct is typically easy to do with recursive functions, so while loops are rarer in ATS2.

### A simple example

### An example using termination metrics

### This page discusses briefly several mechanisms for using loops in ATS.

**Infinitely recursive functions may be a cause for a segfault.** 
(But sometimes, one may want infinite recursion, as in a main loop; when is it not an issue?)  To avoid this possibility, one can take advantage of dependent types and termination metrics, as in [this example](http://www.ats-lang.org/DOCUMENT/INTPROGINATS/HTML/x2439.html).



**A main loop, useful for creating an application that will keep running until something causes it to return.** This can be implemented in several ways.

Firstly, 

```ocaml
implement
main () = main() where { ... }
```