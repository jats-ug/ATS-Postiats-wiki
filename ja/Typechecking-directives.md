* `$effmask_all` - tells the typechecker to ignore the tracking of function
  [[effects|effects]], which is not really helpful for most types of
  programming. It is used by writing `$effmask_all(...)` where the `...` is
  a function call [\[1\]][1].
* `$showtype` - prints out the type of a value or variable in ATS's internal
  type representation. Very helpful for understanding type errors, but the
  exact meaning of the output can still be cryptic for more complicated
  cases. See [[internal types|Internal types]] for more information and
  [[error messages|Error messages]] for an example.

[1]:
https://groups.google.com/forum/#!searchin/ats-lang-users/mask$20effect/ats-lang-users/yqldklykEuM/021vPg65v9gJ
