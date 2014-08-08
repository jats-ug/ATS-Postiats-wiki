## Overview of the stack and heap ##

This page lists common types found in ATS according to whether they are allocated on the stack or heap, or both. Data that is heap allocated can be disposed of using linear types and associated memory allocation and deallocation functions (e.g. malloc and free), or by using a garbage collector (GC). The popular [Boehm GC](http://www.hpl.hp.com/personal/Hans_Boehm/gc/) is known to be supported in ATS2.

The following types are allocated on the stack when used in val or var assignments: types associated with ground sorts (int, bool, char, and addr). Any type with sort `t@ype` (e.g. integers) or type (e.g. addresses).

The following types are allocated on the heap: boxed tuples, viewtypes, datatypes, dataviewtypes, exceptions (they are a dataytpe), lazy types, c-types accessed by pointer, and ref types. [[Strings|Strings]] usually fall under this classification, for instance, they are usually represented as abstypes and/or viewtypes for heap-allocated C strings. Note that a viewtype can be used for stack-allocated variables as well , though this seems to be less common, outside of its [use with var](http://www.ats-lang.org/DOCUMENT/INTPROGINATS/HTML/x3352.html). It is usually the case that heap-allocated types are only amenable to use with the GC or to linear types, not both. For instance, datatypes are for use with a GC, whereas dataviewtypes are linear types managed by the programmer. 


## Using the GC ##

The flag -DATS_MEMALLOC_GCBDW is passed to gcc to support the use of libgc (Bohem GC) for handling memory allocation/deallocation. See this [small project](https://github.com/githwxi/ATS-Postiats/tree/master/doc/PROJECT/SMALL/calculator) for an example Makefile [\[1\]][1]. If using gcc directly on ATS-generated C files for the purpose of portable code, use the -lgc.

## Linear Malloc and Free Functions ##

#### Built-in ATS (de)allocation functions ####

Unlike in C/C++, malloc in ATS does not return null if enough memory is not available, but aborts instead [\[2\]][2].

#### Custom memory (de)allocation functions ####

Here is an example showing a simple way to use user-defined malloc/free [\[3\]][3]:

https://github.com/githwxi/ATS-Postiats/tree/master/doc/EXAMPLE/CA-HSR2/program-1-2

The flag -DATS_MEMALLOC_USER indicates to the ATS compiler that the following
two functions are used for memory allocation/deallocation (for more details on interoperability between C and ATS, see this [chapter on interaction with C](http://www.ats-lang.org/DOCUMENT/INT2PROGINATS/HTML/c1960.html)):

```C
extern
void
*atsruntime_malloc_user (size_t bsz) ;
    
extern
void atsruntime_mfree_user (void* ptr) ;
````

[1]: https://groups.google.com/d/msg/ats-lang-users/SL7fb01wsnk/vU3d9pv-RTkJ
[2]: https://groups.google.com/d/msg/ats-lang-users/eAMszM15vIE/MYi3Rfxe48QJ
[3]: https://groups.google.com/d/msg/ats-lang-users/uRQami8woQQ/l44QkqGq-IoJ