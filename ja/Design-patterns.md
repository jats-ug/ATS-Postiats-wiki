ATS has some design patterns that are less common in the other languages.
This page explains the patterns.

## Takeout-Addback pattern

Static meaning with ATS's type isn't good at everything.  Sequence of the
static meaning is divided by event driven architecture or thread.

In such case, we should use some protocol like a session.  The session is
opened calling takeout static function.  After takeout and before addback,
we can touch and use static meaning associated with the session.  It's
closed calling addback static funcion.

The arrayptr library in prelude is a good example.

```ocaml
(* File: prelude/SATS/arrayptr.sats *)
praxi
arrayptr_takeout
  {a:vt0p}{l:addr}{n:int}
(
  A: !arrayptr (INV(a), l, n) >> arrayptrout (a?, l, n)
) : array_v (a, l, n) // end of [arrayptr_takeout]

praxi
arrayptr_addback
  {a:vt0p}{l:addr}{n:int}
(
  pf: array_v (INV(a), l, n) | A: !arrayptrout (a?, l, n) >> arrayptr (a, l, n)
) : void // end of [arrayptr_addback]
```

The arrayptr has no static meaning, because it's simple pointer.  The
array_v has static meaning, because it's dataview.  We can use array_v
between takeout and addback.

For more detail, see [ATSLIB/prelude/arrayptr
library](http://www.ats-lang.org/LIBRARY/prelude/SATS/DOCUGEN/HTML/arrayptr.html#arrayptr_takeout).

## Localized-Template pattern

Many functional languages use closure to inject localized processing into a
function.  ATS also can use closure. However it's sometimes bad idea,
because closure is a resource and should be maintained by linear type or GC.

ATS code can use locallized template for the situation.  In following code,
"plus1" is defined as default function template implementation on global
name space, and "call_plus1" is also defined as function templete.  Simply
calling "call_plus1" produces that "plus1" as default implementation is
called.  On the other hand, calling "call_plus1" binding "plus1" with local
implementation produces that the "plus1" is called.

```ocaml (* File: test_template.dats *)  #include
"share/atspre_staload.hats"

extern fun{} plus1: () -> int extern fun{} call_plus1: () -> int

implement{} plus1 () = 0 + 1                (* default implementation *)
implement{} call_plus1 () = plus1 ()

implement main0 () = {
  val () = println! (call_plus1 ())         (* => 1 *)
  val v = 10
  val () = let implement{} plus1 () = v + 1 (* local implementation *)
           in println! (call_plus1 ()) end  (* => 11 *)
}
```

上記のコードは以下のコマンドでコンパイルできます。

``` $ patscc -o test_template test_template.dats $ ./test_template 1 11 ```

Note "call_plus1" should be defined as templete, if you would like to
localize the child function using template.

For more detail, see [ATSLIB/prelude/strptr
library](http://www.ats-lang.org/LIBRARY/prelude/SATS/DOCUGEN/HTML/strptr.html#strnptr_foreach).
