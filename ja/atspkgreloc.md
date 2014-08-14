Atspkgreloc is meant to be a convenient tool for people to share ATS code
[\[1\]][1].

The command plus some examples can be found at:

https://github.com/githwxi/ATS-Postiats/tree/master/utils/atspkgreloc/

Say we have the following line in some code;

```ocaml staload T =
"{http://www.ats-lang.org/LIBRARY}/contrib/libats-hwxi/intinf/SATS/intinf_t.sats"
```

What is inside {...} is to be replaced with the value of `ATSPKGRELOCROOT`
after pre-processing.  Following is a complete example. Say the example is
stored in a file named test02.dats. If you do

``` patsopt --pkgreloc -d test02.dats ```

you will see some text in JSON format printed out. For instance, one entry
looks like this:

```json { "pkgreloc_kind": "staload" , "pkgreloc_target":
"/tmp/.ATSPKGRELOCROOT-hwxi/contrib/libats-hwxi/intinf/DATS/intinf_t.dats" ,
"pkgreloc_source":
"http://www.ats-lang.org/LIBRARY/contrib/libats-hwxi/intinf/DATS/intinf_t.dats"
} ```

You can use the command atspkgreloc to relocate the source to the target:

``` patsopt --pkgreloc -d test02.dats | atspkgreloc ```

Then test02.dats can be compiled by using patscc. The following Makefile
contains all the details needed:

https://github.com/githwxi/ATS-Postiats/blob/master/utils/atspkgreloc/TEST/Makefile

```ocaml (* ** A test for atspkgreloc *)  (* ****** ****** *)  // #include
"share/atspre_staload.hats" // (* ****** ****** *)

#define ATS_PACKNAME "atspkgreloc_test02"

(* ****** ****** *)  // require
"{http://www.ats-lang.org/LIBRARY}/contrib/libgmp/CATS/gmp.cats" //
require(*HX-2014-05-01: this one is required by others*)
"{http://www.ats-lang.org/LIBRARY}/contrib/libats-hwxi/intinf/SATS/intinf_vt.sats"
// (* ****** ****** *)

staload
"{http://www.ats-lang.org/LIBRARY}/contrib/libats-hwxi/intinf/SATS/intinf.sats"
staload T =
"{http://www.ats-lang.org/LIBRARY}/contrib/libats-hwxi/intinf/SATS/intinf_t.sats"
staload _ =
"{http://www.ats-lang.org/LIBRARY}/contrib/libats-hwxi/intinf/DATS/intinf_t.dats"
staload _ =
"{http://www.ats-lang.org/LIBRARY}/contrib/libats-hwxi/intinf/DATS/intinf_vt.dats"

(* ****** ****** *)

fun
fact{i:nat}
(
  x: int (i)
) : $T.Intinf = let
in
//
if x = 0
  then $T.int2intinf(1)
  else let
    val r1 = fact (x - 1)
  in
    $T.mul_int_intinf (x, r1)
  end // end of [else]
// end of [if]
//
end // end of [fact]

(* ****** ****** *)

overload print with $T.print_intinf

(* ****** ****** *)

implement main0 () = () where { // val N = 100 val () = println! ("fact(",
N, ") = ", fact(N))  // } (* end of [main0] *)

(* ****** ****** *)

(* end of [test02.dats] *)  ```


[1]:
https://groups.google.com/forum/?utm_medium=email&utm_source=footer#!msg/ats-lang-users/yjYFjH5bskk/BJxhB67owGEJ
