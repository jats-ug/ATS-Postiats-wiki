This page lists features present in ATS, either in the current version, or in a prior implementation. Additionally, possible features are listed (please do not add possible future features without discussing the viability with the ATS maintainer(s)).

## Current features
For now, there is no comprehensive list, but please check [here](http://www.ats-lang.org/) for an overview.

## Prior features
* Checking that `prfun` and `prfn` implementations exist (see [[ATS/LF|ATSLF]]).

## Possible features
* Concurrent val statement evaluation, e.g., 
If I want to indicate to the compiler that that `do_this` and `do_that`
can be evaluated in parallel, I use the following syntax:
```ocaml
prval (pf1, pf2) = ... // [pf1] and [pf2] are separated
val ... = do_this (pf1 | ...) // do_this is checked to be pure
and ... = do_that (pf2 | ...) // do_that is checked to be pure
```
Basically, the requirement is that (1) `do_this` and `do_that` can
only manipulate resources they own and (2) they do not share
any resources between them. See 
[here](https://github.com/githwxi/ATS-Postiats/issues/79) for possible test code.

* Self-hosting compiler in ATS2 ([not anytime soon](https://groups.google.com/d/msg/ats-lang-users/QIoMx1t6aLI/TAk7ugSsMB0J)).