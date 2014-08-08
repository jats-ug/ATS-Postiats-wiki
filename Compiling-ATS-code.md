## ATS Compiler
atscc, sometimes called patscc in ATS/Postiats, is a wrapper utility to allow easier compilation of ATS source code than by using patsopt directly.

Here is more information on 'patscc' and 'patsopt':

http://www.ats-lang.org/RESOURCE/#ATS_utility

In order to compile ATS2 programs, you can now do
something like:

```
patscc -o test test.dats test_header.sats test_helper.dats
```

For considerably large and complex projects (involving both ATS code and C code), it may be beneficial to use 'patsopt' directly in a Makefile. In most cases, 'patscc' is adequate for handling the compilation of ATS code.


## Using Makefiles


## Using CMake

## Compiling Portable Code
