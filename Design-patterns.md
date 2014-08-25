ATS has some design patterns that are less common in the other languages.
This page explains the patterns.

## Takeout-Addback pattern

Static meaning with ATS's type isn't good at everything.
Sequence of the static meaning is divided by event driven architecture or thread.

In such case, we should use some protocol like a session.
The session is opened calling takeout static function.
After takeout and before addback, we can touch and use static meaning associated with the session.
It's closed calling addback static funcion.

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

The arrayptr has no static meaning, because it's simple pointer.
The array_v has static meaning, because it's dataview.
We can use array_v between takeout and addback.

For more detail, see
[ATSLIB/prelude/arrayptr library](http://www.ats-lang.org/LIBRARY/prelude/SATS/DOCUGEN/HTML/arrayptr.html#arrayptr_takeout).

## Localized-Template pattern

For more detail, see
[ATSLIB/prelude/strptr](http://www.ats-lang.org/LIBRARY/prelude/SATS/DOCUGEN/HTML/strptr.html#strnptr_foreach).