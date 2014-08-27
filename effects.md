Functions can have various effects that may be tracked by the typechecker [\[1\]][1].  These are described immediately after the : in the function definition (note that there should be no space between the ':' and the '<>'.) As well as :<> meaning pure and : (no '<>') meaning any effects may occur, there are various other things that can appear between the '<>' symbols.

* `!exn` - the function possibly raises exceptions
* `!ntm` - the function possibly is non-terminating
* `!ref` - the function possibly updates shared memory
* `0` - the function is pure (has no effects)
* `1` - the function can have all effects
* `fun` - the function is an ordinary, non-closure, function
* `clo` - the function is a stack allocated closure
* `cloptr` - the function is a linear closure that must be explicitly freed
* `cloref` - the function is a peristent closure that requires the garbage collector to be freed. 
* `lin` - the function i slinear and can be called only once
* `prf` - the function is a proof function
* `!wrt` - indicates that a function may write to a location it owns. For instance, ptr_set incurs such an effect. 
* `!ref` - can read from or write to a location that one knows exists but does not own.

These can be combined, eg. <lincloptr1>. Function effects are all of [[sort|sort]] `eff`.

[1]: https://groups.google.com/forum/#!searchin/ats-lang-users/function$20effects/ats-lang-users/88CYxwKl0M0/GAvDQQKkzJ8J