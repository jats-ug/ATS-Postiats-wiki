Because ATS and C have the same underlying semantics (i.e. machine data and code representation), it is natural to write code where some of it is in C and some is in ATS. Perhaps the most natural scenario is to utilize a popular C library, of which there are many interfaces are already available (see [[contrib|contrib]]). Another example is handling especially tricky or critical code in ATS to make the software more resilient. Since many existing languages also support a C interface, this mechanism can be used to interface with other languages as well, although in many cases it may make more sense to use the co-programming features supported by the [[code generator|code generation]] [ATS-parse-emit](https://github.com/githwxi/ATS-Postiats-contrib/tree/master/projects/MEDIUM/ATS-parse-emit), which allows ATS code to be directly compiled to the target language. Note however, as each language has different semantics, the ATS code will not be portable across languages using ATS-parse-emit, and additionally, a code generator and standard library (e.g. [[ATSLIB|ATSLIB]]) should be written for each target language.


## C interface cheat sheet
Note that thorough documentation is available for most of these in the [[ATS book|http://www.ats-lang.org/DOCUMENT/INT2PROGINATS/HTML/book1.html]], in the section *Interaction with C*.

* Make an ATS function available in C (can be implemented in ATS or C):
```ocaml
extern
fun myfun (n: int, res: int): int = "ext#myfun_in_c"  (* call as myfun_in_c(int, int) in C *)

(* Have the C function name be the same as the ATS function name: *)
extern
fun myfun (n: int, res: int): int = "ext#"  (* call as myfun(int, int) in C *)
```

* Make an ATS function available in C as a macro (must be implemented in C):
```ocaml
extern
fun myfun (n: int, res: int): int = "mac#myfun_in_c"  (* call as myfun_in_c(int, int) in C *)

(* Have the C function name be the same as the ATS function name: *)
extern
fun myfun (n: int, res: int): int = "mac#"  (* call as myfun(int, int) in C *)
```

* Make an ATS function available in C **as a static function** (can be implemented in ATS or C):
```ocaml
extern
fun myfun (n: int, res: int): int = "sta#myfun_in_c"  (* call as myfun_in_c(int, int) in C *)

(* Have the C function name be the same as the ATS function name: *)
extern fun myfun (n: int, res: int): int = "sta#"
// or:
static fun myfun (n: int, res: int): int
```

* typedef a C type in ATS; use `$extype`, e.g.:
```ocaml
typedef Cint2 = $extype"struct{ int x; int y; }"
```
* Access a C value in ATS; use `$extval(ATS-type, "C-variable")`, e.g.:
```ocaml
macdef stdin_ref = $extval(FILEref, "stdin")
```
* Access a C function in ATS; use `$extval(ATS function signature, "C-function-name")`, e.g.:
```ocaml
macdef atoi = $extval(string -> int, "atoi")
```

## Writing interfaces to C libraries
As mentioned above, [[contrib|contrib]] has numerous examples, and will be a good place to start to get a feel for how it is done. 

(Fill in more here)


## Sharing constants statically and dynamically between ATS and C
It can be useful to make available constants in both the statics and dynamics of ATS, while also having
the constant available in C. There are separate issues when going from ATS to C or from C to ATS:
### Making an ATS constant available to C

Say you want to define a constant `N` that will be available in C and the statics and dynamics of ATS, e.g.:

```C
#define N 100
```
Put the above line in a file, say `define.hats`, then just put the following lines at the beginning of your code:

```C
%{^
// available in C
#include "define.hats"
%}
// available in ATS:
#include "define.hats"
```
`N` is now an integer of indexed type in ATS, making it amenable to use with dependent types.

### Making a C constant available to ATS

This is a little more tricky, but can be done by exploiting macro expansion (however, the ATS constant will necessarily have a different name in order to avoid infinite recursion). Say we have a macro in C named MY_MACRO. The following can be put in a file, say `mymacro_hats`.

```ocaml
#define __ATS(x) x

__ATS(#define ATS_MY_MACRO MY_MACRO)
```

Then use `gcc -E`, for example, to preprocess `mymacro_hats` to generate a HATS file `mymacro.hats`, which can be included in ATS code directly.
