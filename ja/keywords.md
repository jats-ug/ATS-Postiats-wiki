* `castfn` - a function (`fn`) that changes the type, both dynamically and
  statically, of its argument. The converted value is returned. When only a
  static `castfn` is needed, one can use the `cast` and related functions in
  `unsafe.sats` to save time (a common use is converting a pointer from C to
  some other viewtype).
* `fn` - non-recursive function (`fun`). Used in place of `fun` for
  optimization purposes (is this true?) and as well as to check against the
  possibility of an accidental infinite loop.
* `fun` - a function that can be recursive.
* `implement` - used to implement a function that has been defined using
  `fun` or `fn`
