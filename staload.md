Note that staload  in ATS is a bit like #include in C. However,
staload and #include are implemented totally differently.

By staloading a file 'foo.sats' as follows, a namespace is created
for 'foo.sats':

```ocaml
staload FOO = "foo.sats"
```

A name xyz declared in 'foo.sats' should be referred to as $FOO.xyz.

If we next do:

```ocaml
staload FOO2 = "foo.sats"
```
then there is no actual loading except FOO2 becomes an alias of FOO.

We can also do

```ocaml
staload "foo.sats"
```

which opens up the namespace for 'foo.sats' so that names declared
in 'foo.sats' can be referred to directly.

There is also support for #include in ATS, which simply pastes any
file to be included at the point where #include is located.

Another use of staload is to make template implementations available to
the ATS compiler. For instance, the following line makes the template
implementations in foo.dats available for the purpose of code generation
(from ATS source to C target):

```ocaml
staload _ = "foo.dats"
```
The use of '_' is to make sure that nothing declared in 'foo.dats' gets spilled
out accidentally [\[1\]][1].

Additional references: [\[2\]][2]

[1]: https://groups.google.com/forum/#!searchin/ats-lang-users/%22staload$20_%22/ats-lang-users/qO7XsiR8xA8/E0tufu9pJVkJ
[2]: https://groups.google.com/d/msg/ats-lang-users/4_d_tmGZXIA/8Hc7kMLfsesJ
