dynload の唯一の目的は初期化を行なうことです。

次の行を含むファイル 'foo.dats' があったとします:

```ocaml
dynload "bar.dats"
```

この行は 'bar.dats' に関連する初期化関数の呼び出しにコンパイルされます。この行がない場合には、リンク時のエラー
"..._dynload_flag is undefined" が発生します。

もし 'bar.dats' の初期化関数 (この初期化関数は全ての .dats ファイルにコンパイラが自動的に生成します)
を呼び出したくない場合には、次の行を 'bar.dats' に追加してください:

```ocaml
#define ATS_DYNLOADFLAG 0
```

これには注意が必要です。

通常、'main' 関数の実装を含むファイルにおいてのみ 'dynload' 行を配置する必要があります [\[1\]][1] 。

[1]: https://groups.google.com/d/msg/ats-lang-users/jqFEAf1drXc/uv5x_rx3aMEJ
