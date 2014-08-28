### なぜ私のコードは型検査に通ったにもかかわらずコンパイルできないのですか？


いくつかの理由が考えられますが、特に [コンパイルエラー](compiler-errors.md) の記事にある
`share/atspre_staload.hats` に注意してください。

### ATS ライブラリコードが GPLv3 ということは、コンパイルされた私のコードも GPLv3 で配布しなければならないのですか？


***短かい答***: **いいえ**.

***長い答***: ATS2 コンパイラ (ATS/Postiats) を GCC のように考えてください。

GCC
を使って所有するC言語ソースコードからオブジェクトを生成すると、あなたは生成されたオブジェクトを所有することになります。そして、ATS/Postiats
を使ってあなたが所有する ATS ソースコードからC言語コードを生成すると、生成されたC言語コードを所有することになります。

***より長い答***: 

[ATSLIB](ATSLIB.md) は第一にC言語コードを生成するために使われます。そして、その ATS
ソースコードの作者によって所有された生成済みC言語コードは、ATS2-Postiats-include のヘッダファイル (つまり CATS ファイル)
さえあればコンパイルできます。現時点では、ATS2-Postiats-include-0.1.1.tgz は BSD
ライクライセンスの下で独立してリリースされています。これに関連しますが、ポータブルな ATS コードを書くのであれば、実行オブジェクトの生成時に
`-latslib` オプションを使わないことをおすすめします。

別の例えを GNU 関連のサイトから引いてみましょう:

*質問*: 自由でないプログラムを開発するために GNU Emacs のような GPL ライセンスのエディタを使うことができますか？
それらをコンパイルするのに GCC のような GPL ライセンスのツールを使うことができますか？
(#CanIUseGPLToolsForNF)

*回答*: はい、なぜならばエディタやツールの著作権はあなたが書くコードには影響しないからです。法的には、あなたがどんなツールを使っても、あなたがご自分のコードに適用するライセンスに関しては何の制限も課されません。
プログラムによっては、技術的な都合から自身の一部を出力結果にコピーするものがあります。たとえば、Bisonは標準パーザ・プログラムを出力ファイルにコピーします。そのような場合、出力結果にコピーされたテキストはそのソースコードに及ぶものと同じライセンスによってライセンスされます。一方、プログラムに与えられた入力から派生した出力結果の一部は入力側の著作権状態を継承します。
たまたま、Bisonは自由でないプログラムを開発するのにも使うことができます。これは、わたしたちがBisonの出力結果に含まれるBisonの標準パーザ・プログラムは制限なしに利用できるということを明確に認めることを決定したからです。わたしたちがこう決めたのは、Bisonと同様の他のツールで自由でないプログラムでの利用を認めているものがすでに存在したからです。

### よくありがちな落とし穴に関する情報はどこにありますか？ATS コードを書く際に初心者的な質問をどこで聞くことができますか？**


1番目に、[公式のチュートリアル][1] を読んでください。
2番目に、[ATS プログラミングのヒント][2] が助けになるかもしれません。
3番目に、そのような質問をするための Google グループ [ats-lang-users][3]
があります。どんなに自明でも、少しオフトピックがあっても、一般に興味がないと思われる事柄でもかまいません。
4番目に、[SourceForge のメーリングリスト][4] での議論も有益かもしれません。
5番目に、その他のコミュニティについては [公式のコミュニティページ][5] を見てください。

(時にあいまいな) ATS のエラーメッセージについては、この wiki の [エラーメッセージ](Error-messages.md)
を参照してください。

もし関数型プログラミングの熟練者でなければ、ATS を学ぶ前になんらかの [Standard ML][6] 言語を学んだ方が良いかもしれません。[SML
textbook(s) or introductory ATS notes][7] がその助けになるかもしれません。

[1]: http://www.ats-lang.org/DOCUMENT/#ATSINTRObook
[2]: http://scg.ece.ucsb.edu/software/notes.pdf
[3]: https://groups.google.com/forum/?fromgroups#!forum/ats-lang-users
[4]: https://sourceforge.net/mailarchive/forum.php?forum_name=ats-lang-users
[5]: http://www.ats-lang.org/COMMUNITY/#
[6]: http://en.wikipedia.org/wiki/Standard_ML
[7]: http://www.cs.bu.edu/~hwxi/academic/courses/Spring13/CS320.html

### チュートリアルはどこにありますか？


この wiki の [チュートリアル](tutorials.md) を参照してください。もしくは [Effective ATS series][26]
と [その git リポジトリ][27] も参考になります。また、1つ前の質問に対する回答も読んでください。


### コードやアルゴリズムの例はどこにありますか？


いくつかの例が [ここ][8] にあります。 (ATS1 の例になります)。

[8]: http://www.ats-lang.org/htdocs-old/EXAMPLE/example.html

### リファレンスやドキュメントはどこにありますか？


ATS1 については、非公式 (そして不完全な) リファレンスが [入手可能です][9]。
([そのソースコードもあります。][10])
ATS2 には [自動生成されたライブラリドキュメント][11] があります。
この wiki の [ホームページ](Home.md) には、より多くのドキュメントを含む wiki ページへのリンクがあります。

[9]: http://www.bluishcoder.co.nz/ats/ats-reference.pdf
[10]: https://github.com/doublec/ats-reference
[11]: http://www.ats-lang.org/LIBRARY/

### 問題がないと思えるのに、型エラーや解決できない強制が発生します。私は何を間違えているのでしょうか？


おそらく、たくさんの原因があると考えられます。
依存型は強制を意味します。
あなたが正しい型をどの段階においても使っていて、意図せず似た型を混ぜてしまわないか確かめます。
ATS にはたくさんの同じような型 (や同じような型を持つ関数) があります。
それらは少し違う状況を扱うために使われます。
*ATS に入門したばかりの間は依存型をあまり使わない* ことを推奨します。
それは解決困難な未解決の強制が起きるのを予防するためです。
けれども、一般的には `if` と `case` 式には型注釈を付ける必要があるでしょう。

もし emacs を使っているなら、最初の段階でそのような問題を避けるために [ATS Flymake][12] を使うことを検討してください。

発生する問題といくつかの解決策について、次の例を参照してください。

  - [Example 1][13]
  - [Example 2][14]
  - [Example 3][15]

最後に、ある種のエラーに対するガイドラインとして、この wiki の [エラーメッセージ](Error-messages.md) を参照してください。

[12]: http://www.reddit.com/r/ATS/comments/vx4lq/ats_flymake/
[13]:
https://sourceforge.net/mailarchive/forum.php?thread_name=Pine.LNX.4.64.1207201538580.21676%40csa2.bu.edu&forum_name=ats-lang-users
[14]:
https://groups.google.com/forum/?fromgroups=#!topic/ats-lang-users/bnROVnWcFMU
[15]:
https://groups.google.com/forum/?fromgroups=#!topic/ats-lang-users/oFuXRr4K8ts

### 同じデータ構造内で異なる2つの型を一緒に使ったのに、型検査を通ってしまいました!これはバグですか？


依存型の厳格さを体感した後では、ときおり驚くことでしょう。
しかし短かい答えとして、それはおそらくバグではありません。
[これ][16] は入力として異なる型の値 (例えば `string`, `float`, `int`) を受け付ける `list0` の例です。
[これ][17] はテンプレートにおける例です。
[サブタイピング][18]、とりわけ ATS がどのようにサブタイピングを定義するかに関連することがあります。
これはATS2 における問題ではなく、[ATS2 のあるメジャーリリース][19] で起きたことです。

[16]: http://www.ats-lang.org/DOCUMENT/INTPROGINATS/HTML/x1099.html
[17]:
https://sourceforge.net/mailarchive/forum.php?thread_name=Pine.LNX.4.64.1204041554160.22282%40csa2.bu.edu&forum_name=ats-lang-users
[18]:
http://en.wikipedia.org/wiki/Covariance_and_contravariance_(computer_science)
[19]:
https://sourceforge.net/mailarchive/forum.php?thread_name=727FCEF6-16CE-4249-97B6-750CBB2B2371%40users.sourceforge.net&forum_name=ats-lang-users

### 依存型とは何ですか？


[依存型][20] は値に依存した型です。
ATS における単純な例として、`int (5)` は 5 と等しくなるような全ての整数であるような型です。
そのため、これは実際にはシングルトン型です。

[20]: http://en.wikipedia.org/wiki/Dependent_type

### 線形型とは何ですか？


線形型は [線形論理][21] を利用します。
線形型の概念は、静的なリソースの追跡ができる式によって消費されるリソースとしての観測値、と説明できます。
例えば、式 `(a or b)` を考えるとき、あなたは新しい式を生成しています。
しかし、あなたは `a` と `b` を破棄しなければなりません。
これは、例えば、安全で効果的なメモリ確保を扱うのに有用です。
より詳しくは、[ATSプログラミング入門][22]、[Wikipedia にある線形型に関する記事][23]、この wiki の
[線形型](Linear-types.md) を参照してください。

[21]: http://en.wikipedia.org/wiki/Linear_logic
[22]: http://www.ats-lang.org/DOCUMENT/INTPROGINATS/HTML/c3217.html
[23]:
http://en.wikipedia.org/wiki/Substructural_type_system#Linear_type_systems

### ATS には Windows 版がありますか？


少なくとも近い未来においては入手できません。
けれども、他のプラットフォームと同じビルド手順を使って、[Cygwin][24] 上に ATS をインストールすることはできます。

また [実験的なオンラインツール][25] を使って ATS2 を試すこともできます。
もしくは仮想環境を使って試すこともできます。
ATS の [ビルドとインストール](Building-and-installing.md) を参照してくだい。

[24]: http://www.cygwin.com/
[25]: http://xrats.illtyped.com/code/patsopt



[26]: http://www.ats-lang.org/EXAMPLE/EFFECTIVATS/
[27]:
https://github.com/githwxi/ATS-Postiats/tree/master/doc/EXAMPLE/EFFECTIVATS
