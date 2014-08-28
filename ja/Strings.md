ATS2 には多くの異なる文字列型があります (それらのいくつかは `prelude/basics_sta.sats`
に見られます)。どれを使うべきなのでしょうか？

比較的小さい対象には、文字列に 'strptr1' を使うのが良いでしょう。

文字列の共有が必要になるようなより複雑なアプリケーションでは、リファレンスカウント文字列を使いたくなるかもしれません。ATS2
にはリファレンスカウント文字列を扱う
[strobjref](https://github.com/githwxi/ATS-Postiats/blob/master/libats/SATS/strobjref.sats)
型があります。

プロジェクトの初期では、どの種類の文字列が必要になるのかわからないかもしれません。そんな時、抽象型を導入できます:

```ocaml
absviewtype mystring (l:addr)
```

最初は、`strptr` を元に `mystring` を実装します。後でその実装は用意に変更できます。`strobjref`
や他の実装を元にすることができるのです。

実際には、文字列の共有を許可するとメモリリークを防止することが著しく困難になります。例えば、(バグレポートによれば) graphviz
には多くのメモリリークがあります。ATS はこの種の問題を防止するのにとても有用です [\[1\]][1]。

[1]: https://groups.google.com/d/msg/ats-lang-users/MrWe5tFnR_8/4uTj6ER67OoJ
