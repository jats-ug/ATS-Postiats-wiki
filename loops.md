### Need to copy most info from here:
https://groups.google.com/forum/#!searchin/ats-lang-users/%22for$20loop%22/ats-lang-users/NfHeSJpaq78/zjys-ug5eMUJ


### This page discusses briefly several mechanisms for using loops in ATS.

**Infinitely recursive functions may be a cause for a segfault.** 
(But sometimes, one may want infinite recursion, as in a main loop; when is it not an issue?)  To avoid this possibility, one can take advantage of dependent types and termination metrics, as in [this example](http://www.ats-lang.org/DOCUMENT/INTPROGINATS/HTML/x2439.html).



**A main loop, useful for creating an application that will keep running until something causes it to return.** This can be implemented in several ways.

Firstly, 

```ocaml
implement
main () = main() where { ... }
```