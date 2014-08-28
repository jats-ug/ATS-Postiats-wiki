ATS には他の言語ではあまり一般的ではないような、いくつかのデザインパターンがあります。このページではそんなパターンを説明します。

## Takeout-Addback パターン

ATS の型を用いた静的な意味は万能ではありません。静的な意味の列は、イベントドリブンなアーキティクチャやスレッドによって分断されてしまいます。

そのような場合、セッションのようななんらかのプロトコルを使う必要があります。そのセッションは静的な関数 takeout
を呼び出して開くことにします。takeout から addback までの間で、そのセッションに関連した静的な意味を使うことができます。最後に静的な関数
addback を呼び出してセッションを閉じます。

prelude の arrayptr ライブラリは良い例です。

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

arrayptr は単純なポインタで、静的な意味を持ちません。array_v は dataview で、静的な意味を持っています。takeout と
addback の間において array_v を使うことができます。

詳しくは [ATSLIB/prelude/arrayptr
ライブラリ](http://www.ats-lang.org/LIBRARY/prelude/SATS/DOCUGEN/HTML/arrayptr.html#arrayptr_takeout)
を参照してください。

## Localized-Template パターン

関数にローカルな処理を注入するために、多くの関数型言語はクロージャを使います。ATS
もまたクロージャを使うことができます。けれどもそのようなクロージャの使用は時に良い考えではありません。なぜならクロージャはリソースで、線形型や GC
によって管理しなければならないからです。

このような場合 ATS コードではローカライズされたテンプレートを使うことができます。次のコードでは、"plus1"
はグローバルな名前空間でのデフォルト関数テンプレート実装として定義され、"call_plus1" もまた関数テンプレートとして定義されています。単に
"call_plus1" を呼び出すと、デフォルト実装である "plus1" が呼び出されます。一方で、"plus1" にローカルな実装を束縛した後に
"call_plus1" を呼び出すと、その "plus1" が呼び出されます。

```ocaml
(* File: test_template.dats *)  #include "share/atspre_staload.hats"

extern fun{} plus1: () -> int extern fun{} call_plus1: () -> int

implement{} plus1 () = 0 + 1                (* default implementation *)
implement{} call_plus1 () = plus1 ()

implement main0 () = {
  val () = println! (call_plus1 ())         (* => 1 *)
  val v = 10
  val () = let implement{} plus1 () = v + 1 (* local implementation *)
           in println! (call_plus1 ()) end  (* => 11 *)
}
```

上記のコードは以下のコマンドでコンパイルできます。

```
$ patscc -o test_template test_template.dats
$ ./test_template 1 11
```

テンプレートを使って子供の関数をローカライズしたい場合には、"call_plus1" もテンプレートとして定義しなければならないことに注意してください。

詳しくは [ATSLIB/prelude/strptr
ライブラリ](http://www.ats-lang.org/LIBRARY/prelude/SATS/DOCUGEN/HTML/strptr.html#strnptr_foreach)
を参照してください。
