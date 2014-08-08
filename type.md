ATS is perhaps more advanced than any other languages when it comes to applying type theory an actual language, though this is not its only merit.

For [[dependent types|dependent type]] and [[linear types|linear type]], also see the [[FAQ|Frequently asked questions]].

A type is one of the many [sorts](sort) that a static expression or static identifier can be. Other sorts are:

Ground sorts: int, bool, char, addr. They form the basis of dependent type indices.
View, which are linear (in the sense of linear logic) propositions.
Prop, which are classical propositions.

A t@ype or (any)t@ype may be any size, whereas a type must be the size of a pointer; a polymorphic or template function taking some t@ype as an argument should also take a type. Please not that, in some places, a '0' may replace the '@' in some type-related keywords. For instance, t0ype is introduced as an alpha-numeric alternative to t@ype. However, @[...] can *not* be changed into 0[...].

Viewtype, which are linear types. It can be seen as a type combined with a view.
You can define a new sort using datasort. The first few lines of sllist.dats demonstrate how to define a sort that resembles a list. You can also alias sorts using sortdef, which also lets you piggy-back constraints to a sort called subset sort. See prelude/sortdef.sats for examples. A constraint is simply a static expression of a boolean sort.

For each of the type, view, prop, it is possible to alias, declare abstract quantities, and form algebraic constructors.

<table border="1" bordercolor="#888888" cellspacing="0" style="border-color:rgb(136,136,136);border-width:1px;border-collapse:collapse">
<tbody>
<tr>
<td style="width:60px"> </td>
<td style="width:60px">Static</td>
<td style="width:60px">Type</td>
<td style="width:60px">View</td>
<td style="width:60px">Prop</td>
<td style="width:60px">Viewtype</td>
</tr>
<tr>
<td>Aliasing</td>
<td>stadef</td>
<td style="width:60px">typedef</td>
<td>viewdef</td>
<td>propdef</td>
<td>viewtypedef</td>
</tr>
<tr>
<td>Abstract</td>
<td>sta</td>
<td>abstype</td>
<td>absview</td>
<td>absprop</td>
<td>absviewtype</td>
</tr>
<tr>
<td style="width:60px">Algebraic</td>
<td style="width:60px">(N/A)</td>
<td style="width:60px">datatype</td>
<td style="width:60px">dataview</td>
<td style="width:60px">dataprop</td>
<td style="width:60px"><a href="https://github.com/githwxi/ATS-Postiats/wiki/dataviewtype">dataviewtype</a></td>
</tr>
</tbody>
</table>

Type, view, prop, and viewtype are special cases of statics, so whenever you see typedef, viewdef, propdef and viewtypedef, you can just use stadef. Similarly, for abstract declarations, you can use sta for abstype, absview, absprop, and absviewtype. However, datasort, datatype, dataview, dataprop and dataviewtype are not interchangeable. They define algebraic constructors for a new "thing" (e.g. datatype gives you constructors for a new type, dataview gives you constructors for a new view, and so on). [Reference and further discussion](http://cs.likai.org/ats/ml-programmers-guide-to-ats).

-----------------------
Type Annotation
-----------------------

For type annotation during value binding, it is important to remember the following:

There is a subtle difference between

val x = e: T

and

val x: T = e

It is almost always the case that one requires the former style of annotation
in ATS.

The latter only checks that the type of e is a subtype of T.

This is most commonly addressed when dealing with case or if-then-else expressions.