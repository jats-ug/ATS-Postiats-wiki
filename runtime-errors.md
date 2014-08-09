Runtime errors are unusual in ATS, particularly segmentation faults, but there are a few common reasons for this. Also see the [[memory leaks|Memory leaks]] article.

## Unexpected behavior from a C compiler
Compiler optimization issues crop up from time to time, as every compiler is different for some cases.

### GCC 
* GCC 4.8: possible loop optimization issues: may need `--fno-aggressive-loop-optimization`


