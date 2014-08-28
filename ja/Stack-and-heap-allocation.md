## スタックとヒープの概観 ##

このページでは ATS
での一般的な型を、スタックもしくはヒープもしくはその両方に確保されるかどうかに従って列挙します。ヒープに確保されたデータは、線形型と関連したメモリ確保/解放関数
(例: malloc と free) を使って破棄するか、ガーベッジコレクタ (GC) を使って回収します。一般の [Boehm
GC](http://www.hpl.hp.com/personal/Hans_Boehm/gc/) が ATS2 ではサポートされています。

val や var 割り当てを使った時、次の型はスタックに確保されます: 基礎種 (int, bool, char, addr), 種 `t@ype`
(例: 整数) もしくは種 type (例: アドレス) の型。

次の型はヒープにに確保されます:
ボックス化タプル, viewtype, datatype, dataviewtype, 例外 (それらは dataytpe です), lazy 型,
ポインタでアクセスするC言語型, ref 型。[文字列](Strings.md) は通常、この分類に該当します。例えば、それは abstype
として表現されるか、ヒープに確保されたC言語文字列を表わす viewtype です。viewtype
はスタックに確保した変数としても使うことができることに注意してください。けれども [var
との使用](http://www.ats-lang.org/DOCUMENT/INTPROGINATS/HTML/x3352.html)
を除いて、この用法はあまり一般的ではありません。ヒープに確保された型は、GC
を使うか線形型になるかのどちらか一方に従い、通常は両方を使うことはありません。例えば、datatype は GC を使う一方、dataviewtype
は線形型でプログラマによって管理されます。


## GC の使用 ##

メモリの確保/解放に libgc (Bohem GC) を使用するためには、フラグ -DATS_MEMALLOC_GCBDW を gcc
に渡します。Makefile の例として、この
[小さなプロジェクト](https://github.com/githwxi/ATS-Postiats/tree/master/doc/PROJECT/SMALL/calculator)
を参照してください [\[1\]][1]。ポータブルなコードにするために ATS が生成したC言語ファイルを直接 gcc から使う場合には、-lgc
を使ってください。

## 線形の malloc と free 関数 ##

#### ATS ビルトインの確保/解放関数 ####

C/C++ と異なり、十分なメモリがない場合でも、ATS の malloc は NULL を返しません。その代わりにアボートします
[\[2\]][2]。

#### カスタムなメモリ確保/解放関数 ####

ここではユーザが定義した malloc/free を使うための単純な方法の例を示します [\[3\]][3]:

https://github.com/githwxi/ATS-Postiats/tree/master/doc/EXAMPLE/CA-HSR2/program-1-2

フラグ -DATS_MEMALLOC_USER はメモリの確保/解放に次の2つの関数を使うよう、ATS コンパイラに指示します (C言語と ATS
の相互運用の詳細については、この [章 "C言語との相互呼び出し"]
(http://www.ats-lang.org/DOCUMENT/INT2PROGINATS/HTML/c1960.html) を参照してください):

```C
extern void *atsruntime_malloc_user (size_t bsz) ;
    
extern void atsruntime_mfree_user (void* ptr) ;
````

[1]: https://groups.google.com/d/msg/ats-lang-users/SL7fb01wsnk/vU3d9pv-RTkJ
[2]: https://groups.google.com/d/msg/ats-lang-users/eAMszM15vIE/MYi3Rfxe48QJ
[3]: https://groups.google.com/d/msg/ats-lang-users/uRQami8woQQ/l44QkqGq-IoJ
