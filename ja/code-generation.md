別の言語とやりとりするためには ATS と別の言語をC言語のインターフェイスを通して繋ぐのが通常の方法です。しかし、いくつかのケースでは ATS
を直接別の言語にコンパイルすることが望ましいでしょう。

現状では、次の言語にコンパイルすることが可能です:

* C言語 (デフォルトの動作です。GCC, LLVM/Clang, TinyCC を含むいくつかのコンパイラで動作します。)
* Javascript (C言語コードを Javascript にコンパイルする emscripten コンパイラをサポートしています
[\[1\]][1]。)
*
[Python](https://github.com/githwxi/ATS-Postiats-contrib/tree/master/projects/MEDIUM/ATS-parse-emit/Python)

### はじめに

ATS2 コンパイラはC言語のサブセットをターゲットにしています。ATS2 コンパイラの出力を解析して、別のプログラミング言語 (例: 現状では
Python です) の実行可能コードに変換する、ATS-parse-emit (上記のリンク参照) ライブラリ/ユーティリティがあります。

そのサブセットは次の構文から成ります (atsparemit.sats を参照)。

* s0exp (型を表わす静的な式)
* d0exp (動的な式、つまり実行時に実行されて値を作る式。しかしどのような制御フローも意味しません。)
* instr (低レベルな命令ノード。例: if-then-else, return, jump, assignment)
* d0ecl (型宣言, マクロ, 外部の関数, ATS2 ソースコードからコンパイルされた関数)

関数宣言 (f0decl) は、(外部の静的な) 関数のカインド, ヘッディング (すなわちシグニチャ、つまり (名前の付いた)
引数のリストと返り値の型), 任意で本体 (ローカルな変数定義のリストと命令のリスト)
で構成されています。さらにC言語の規則に従って、あらゆる関数は2回発行されます: 1度目は前方宣言として
(この場合、本体は含まず、引数には名前がないかもしれません)、そして2度目は定義としてです (この場合、本体があることになります)。

### 関数の変換言語

より完全には次のドキュメントを参照してください:

https://github.com/hsk/docs/blob/master/ats/compiled_c_macro.md

* `ATSINSlab/ATSINSgoto` パターンマッチをコンパイルするために使われます。
* `ATSINSflab/ATSINSfgoto` 末尾再帰最適化をサポートするために使われます。
* `ATSmove_boxrec(tmp, T)` 型 T の未初期化レコードを生成して、それを tmp に割り当てます。
* `ATSmove_boxrec` は常にフィールドの初期化を表わす代入をともないます; それらはたいてい一緒にグループにされ、次のように変換されます:

```python
tmp = (v1, v2, ..., vn) # (python)
```

### Python

コードを Python にコンパイルに際して、現状ではポインタ操作を扱う計画はありません。または Cython を使うことになるかもしれません。

Python はジャンプをサポートしていないので、ATSINSgoto と ATSINSfgoto
を削除する必要があります。私はこの対策を行なう予定です。



[1]: https://groups.google.com/d/msg/ats-lang-users/WVje4zG4bKA/p-XulrfBFwIJ
