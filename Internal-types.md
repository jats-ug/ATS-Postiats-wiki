Internal types are introduced in the file `pats_staexp2.sats`, and having a better understanding of how these types relate to actual ATS types will be [[helpful in debugging|Error messages]].

* `S2Eapp` - an application term.
* `S2Ecst` - a type constant (for instance, int, bool, list, etc.)
* `S2Eeff` - function effects.
* `S2Eexi` - an existentially quantified type.
* `S2Eint` - machine precision integer.
* `S2Eintinf` - infinite precision integer; commonly used for integer sorts in most compiled versions of atsopt (patsopt).
* `S2Evar` - a (typically universally quantified) variable.
* `S2Etop (0; T)` means `T?`  `//Need to verify in ATS2`
* `S2Etop (1; T)` means `T?!` `//Need to verify in ATS2`
* `S2EVar` - an (existentially quantified) unification variable introduced by the typechecker.