This is a list of sorts (*i.e.* static types) that are the basis for the static language of ATS.

## Ground Sorts

These are sorts that are present as types in C. (Is this true?) Combined with other sorts and features of ATS, this allows us to prove at compile-time propositions made involving C types (or more complex types involving these ground sorts). This means also that every ground sort has an analogous dynamic type of the sort t@ype:
**int, bool char, addr**

## Other sorts

**cls, eff, prop, t@ype, type, view, viewt@ype, viewtype**

**eff 's** are function [[effects|effects]]. The [internal type](Internal types) is S2Eeff.  

**Views** are linear resources that signify a certain type is accessible from an associated variable. At-views, or @ views, are a special case of views which signify that a certain type is dereferencable at a specified memory location; they are used with pointers.