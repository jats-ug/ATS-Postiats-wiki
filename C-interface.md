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

* Call a C function directly

```ocaml
val N = 21
val _ = $extfcall(int, "fprintf", stdout_ref, "The answer to everything is %i\n", 2*N)
(* Note that the first argument to $extfcall is the return type in ATS of the C function,
in this case 'int' and 'fprintf' respectively. *) 
```

* typedef a C type in ATS; use `$extype`, e.g.:
```ocaml
typedef Cint2 = $extype"struct{ int x; int y; }"

(* Rather using a cast to convert between Cint2 and @(int,int) in ATS,
   something like the following example can be done using the 'of' keyword  *)

typedef Cint2 =
$extype_struct"struct{int x;int y;}" of { x= int, y= int }

implement
main0 () =
{
//
var xy: Cint2;
val () = xy.x :=  1
val () = xy.y :=  2
//
val () = println! ("xy.x = ", xy.x)
val () = println! ("xy.y = ", xy.y)
//
} (* end of [main0] *)

```
* Access a C value in ATS; use `$extval(ATS-type, "C-variable")`, e.g.:
```ocaml
macdef stdin_ref = $extval(FILEref, "stdin")
```
* Access a C function in ATS; use `$extval(ATS function signature, "C-function-name")`, e.g.:
```ocaml
macdef atoi = $extval(string -> int, "atoi")
```
* Paste C code embedded in a `.[ds]ats` file into an unspecified location in the `_[ds]ats.c` file.:
```
%{ C code goes here %}
```
* Paste C code embedded in a `.[ds]ats` file at the beginning of the `_[ds]ats.c` file.:
```
%{^ C code goes here %}
```
* Paste C code embedded in a `.[ds]ats` file at the end of the `_[ds]ats.c` file.:
```
%{$ C code goes here %}
```
* Paste C code embedded in a `.sats` to a  `_dats.c` file in which the corresponding `.dats` file [[staloads|staload]] the `.sats` file.:
```
%{# C code goes here %}
```

## Writing interfaces to C libraries
As mentioned above, [[contrib|contrib]] has numerous examples, and will be a good place to start to get a feel for how it is done. 

When creating an interface to a C library, there are typically three directories that need to be created: `SATS`, `CATS`, and `DATS`. The first two are very common, and the third is less common, since often all dynamics are already taken care of by the C library functions. The primary functional interfaces in ATS are defined in `[lib].sats` in the `SATS` directory, where `[lib]` is our library of interest. The `[lib].sats` file will reference a `.cats` file in the `CATS` directory, which is essentially a C wrapper for the C library functions, e.g., the following form is typically found in `[lib].sats`:

```ocaml
%{#
//
#include "[lib]/CATS/[lib].cats"
//
%} // end of [%{#]
```

The `[lib].cats` file accomplishes two things: it annotates existing functions and definitions in the C library that are intended to be included in the ATS interface, and more importantly, it often defines C wrappers that more directly reflect the function signature in ATS. The `[lib].cats` file is a C file, and should include the relevant C library wrappers. Often this is just one C include file:

```C
#include <[lib].h>
```

The `[lib].dats` file in the `DATS` directory, if it exists, should implement functions that are implemented in ATS but not in the C library (or functions that are implemented in ATS and are preferred over the implementation in C).

''(Fill in more here)''


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