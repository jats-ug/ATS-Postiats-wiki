## ATS2

### ATS/Postiats 

The name for the current compiler of ATS2, the successor of ATS (or ATS1).

The actual implementation of ATS/Postiats started in the March of 2011, and it took about two and one-half years to reach the first release of ATS2 at the beginning of September, 2013. As of now, the code base for the compiler of ATS2 consists of 150,000+ lines of code (LOC), which are nearly all written in ATS1.

When compared to ATS1, the single most important new feature is the template system of ATS2. This is a feature that could potentially change the way a programmer writes his or her code. One can certainly feel that this is a very powerful feature (a bit like feeling that OOP is a very powerful feature). However, how this feature should be properly and effectively used in practice needs a lot more investigation.

Another thing about ATS2 is that it is a lot leaner than ATS. One can make good use of ATS2 without any need for compiled library (libatslib.a). Also, GC support in ATS1 is now removed; if needed, third-party GC (e.g., Bohem-GC) can be readily employed.

## ATS1

### ATS/Anairiats

The first implementation written in ATS itself, consisting of nearly 100,000 lines of source code. When compared to ATS/Geizella, a previous implementation of ATS, ATS/Anairiats is significantly more efficient, and in general it issues more informative messages for identifying program errors.

Bootstrapping via gcc  In order to bootstrap ATS/Anairiats, one needs to first check out the following svn directory and name it as some local directory, say, "FOO":

`svn co https://ats-lang.svn.sourceforge.net/svnroot/ats-lang/trunk FOO`
Note that this checkout puts the C code needed for bootstrapping in a directory of the name `FOO/bootstrap0`.
Please go into the directory "FOO" and then execute 'make all'.

Bootstrapping via ocaml  It is also possible to use the ATS/Geizella compiler (written in OCaml) for bootstrapping ATS/Anairiats. This can be done by checking out the following svn directory and name it as the local directory `FOO/bootstrap0`:

```
svn co https://ats-lang.svn.sourceforge.net/svnroot/ats-lang/bootstrap/geizella \
  FOO/bootstrap0
```

After this is done, please go into the directory `FOO` and then execute `make all-geizella`.

### ATS/Geizella

A previously released implementation of ATS (written in OCaml and C). In this implementation, the native unboxed data representation (as is in C) is adopted, and this makes ATS/Geizella particularly well suited for direct interaction with C. As for parametric polymorphism, it is supported in ATS/Geizella through the use of templates. ATS/Geizella is now largely out of active use as ATS/Anairiats, a compiler for ATS that is almost entirely written in ATS, has been bootstrapped successfully (with the help of ATS/Geizella).

### ATS/Proto

The first implementation of ATS. In this implementation, the standard boxed data representation is used to support parametric polymorphism. As of now, ATS/Proto is no longer actively maintained and its main purpose is to serve as an example for future reference.

## Predecessors

* [Xanadu](http://www.cs.bu.edu/~hwxi/Xanadu/Xanadu.html); mainly for dependent types with imperative style.
* [Dependent ML](http://www.cs.bu.edu/~hwxi/DML/DML.html); mainly for dependent types with functional style.

## Influential languages
* [Standard ML](https://en.wikipedia.org/wiki/Standard_ML); mainly the syntax.
* [C](https://en.wikipedia.org/wiki/C_(programming_language)); mainly the semantics.