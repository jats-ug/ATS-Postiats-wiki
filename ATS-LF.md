ATS/LF ([Logical Framework](https://en.wikipedia.org/wiki/Logical_framework)) supports a form of (interactive) theorem-proving;  ATS advocates a programmer-centric approach to program verification that combines programming with theorem-proving in a syntactically intertwined manner. 

## Proofs, theorems, and axioms 

* axiom - `praxi`; States a theorem without proof. Use only under careful consideration.
* proof - `prfun`; States a theorem where the author is required to give a proof. In ATS2, the requirement is not currently enforced, making prfun similar to praxi in practice [\[1\]][1].
* proof - `prfn`; non-recursive version of prfun
* theorem - `prop`; a type in ATS that represents a theorem.

Note that proof functions can (and should) be implemented using the  `primplement` keyword, similar to `implement` for dynamic function implementations. More details can be found in the ATS2 Book.


[1]: https://groups.google.com/d/msg/ats-lang-users/enDXT0GaoaM/HKJcjCJSdoYJ)