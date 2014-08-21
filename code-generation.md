While the usual way to interact with other languages is to interact through C interfaces in both ATS and the other language, in some cases it may be desirable to directly compile ATS to another language.

Currently, this is possible for the following languages:
* C (The default; several compilers are known to work, including GCC, LLVM/Clang, and TinyCC.)
* Javascript (Compilation is supported by the emscripten compiler which compiles C code to javascript [\[1\]][1].)
* [Python](https://github.com/githwxi/ATS-Postiats-contrib/tree/master/projects/MEDIUM/ATS-parse-emit/Python)

### Introduction

ATS2 compiler targets a subset of C programming language. There is a library/utility ATS-parse-emit (see above for a link) that parses ATS2 compiler output and transforms it into executable code in other programming languages (e.g., currently, Python).

The subset is comprised by the following kinds of syntax (see atsparemit.sats):

* s0exp (static expressions, for types)
* d0exp (dynamic expressions, i.e. expressions that get executed at run-time to yield values, but not involving any control flow)
* instr (low-level instruction nodes, e.g. if-then-else, return, jump, assignment)
* d0ecl (declarations of types, macros, external functions, and functions compiled from ATS2 source code)

A function declaration (f0decl) consists of function kind (external/static), heading (i.e. signature, that is, list of (named) arguments and return type) and optional body (list of local variable definitions and list of instructions). Moreover, in accordance with C rules, every function is emitted twice: firstly, as a forward-declaration (contains no body, arguments might be unnamed), and secondly, as a definition (in this case, body is present).

### Language translating functions

For more complete documentation, please see:

https://github.com/hsk/docs/blob/master/ats/compiled_c_macro.md

* `ATSINSlab/ATSINSgoto` are used for pattern matching compilation.
* `ATSINSflab/ATSINSfgoto` are used to support tail-call optimization.
* `ATSmove_boxrec(tmp, T)` creates an uninitialized record of the type T, and
assign it to tmp.
* `ATSmove_boxrec` is always followed by a few assignments for field initialization;
they should probably grouped together and then translated into something like:
```python
tmp = (v1, v2, ..., vn) # (python)
```

### Python
For compiling code to Python, there is currently no plan to handle pointer operations.
Or one may go the Cython road.

Because Python does not support jumps, ATSINSgoto and ATSINSfgoto
need to be removed. I will try to do it.



[1]: https://groups.google.com/d/msg/ats-lang-users/WVje4zG4bKA/p-XulrfBFwIJ