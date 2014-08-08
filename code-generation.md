While the usual way to interact with other languages is to interact through C interfaces in both ATS and the other language, in some cases it may be desirable to directly compile ATS to another language.

Currently, this is possible for the following languages:
* C (The default; several compilers are known to work, including GCC, LLVM/Clang, and TinyCC.)
* Javascript (Compilation is supported by the emscripten compiler which compiles C code to javascript [\[1\]][1].)
* [Python](https://github.com/githwxi/ATS-Postiats-contrib/tree/master/projects/MEDIUM/ATS-parse-emit/Python)

### Language translating functions
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