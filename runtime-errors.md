Runtime errors are unusual in ATS, particularly segmentation faults, but there are a few common reasons for this. Also see the [[memory leaks|Memory leaks]] article.

## Unexpected behavior from a C compiler
Compiler optimization issues crop up from time to time, as every compiler is different for some cases.

### GCC 
* GCC 4.8: possible loop optimization issues: may need `--fno-aggressive-loop-optimization`


## Segmentation faults

These are generally pretty rare, and can occur because of an unintended infinite recursion; these are generally easy to find. For more information, see [[loop|Loop]]s. These can generally be avoid by using [[termination metrics|termination metrics]], or if not termination proof is to be provided, the compiler can generate run‑time termination checks, if it is passed this command‑line option: `-D_ATS_TERMINATION_CHECK`.

If you are doing something unsafe with memory, though, particularly when interfacing with other C code, there are other possibilities. For more information, see [[memory leaks|Memory leaks]].