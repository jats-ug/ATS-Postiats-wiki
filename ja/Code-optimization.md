## 賢いコードの最適化を試みるべきでない場合 ##

- ATS2 における `macdef`
は型を含むことができます。関数を使うのが不便な場合においてのみマクロを使ってください。[たいていマクロ使ってもあなたのコードが速くなることはありません][1]。`gcc
-O2` が積極的に関数のインライン化を行なうためです。

  [1]: https://groups.google.com/d/msg/ats-lang-users/Ql64LA9Wi88/fwrR7kJ3Ww0J

- 同じスコープでスタックに異なる val を宣言を分けるという知識を利用することは、自然なコーディングスタイルです。例えば:

~~~ocaml
    val x = 5
    val x = 7
~~~

この場合、定数伝搬 (constant propagation) によって、二番目の 'x'
のために追加のメモリ領域が確保されることはありません。このようなコーディングスタイルがなんらかのペナルティになることは一般にありえません。

## 最適化のヒント ##

- 以下のように、線形型のインスタンスを解放し、すぐに同じ値を新しく生成して返すような case 式を書く代わりに:

        case+ x of
        | ~GRgenes (genes) => GRgenes (genes)

    次のように書きます:

        case+ x of
        | GRgenes _ => (fold@ x; x)

    なぜなら、`@fold` は "ノーオペレーション" にコンパイルされるためです。



-
可能な場合には関数呼び出しから無名のクロージャ定義を取り除いてください。これはループが呼び出されるたびにそれらが生成されるのを避けるためです。例えば、単純な文字列の比較関数は次のように作ることができます:

        val cmp_str = lam(x:string,y:string):int =<cloref> compare (x, y)


## ひきしまったコードを作る ##

例えば組み込みアプリケーションのようにコードサイズが重要な場合、次を検討してみてください:

### 例外を使わないコード ###

例外の使用は、メモリリークを引き起こしたり GC が必要になったり、またオーバーヘッドの可能性もあることに注意してください。もし、あなたの ATS
コードで例外を利用しないのであれば、そのコードをコンパイルする際に次のフラグを使うことができます [\[1\]][1]:

\-D_ATS_EXCEPTION_NONE

これでより小さいオブジェクトコードが生成されるようになります。

次の行を含む hello.dats ファイルで試してみましょう:

```ocaml
implement main0 () = print "Hello, world!\n"
```

```
patscc -o hello1 hello.dats
size hello1
   text    data     bss     dec     hex filename
   3434     668      40    4142    102e hello1

patscc -D_ATS_EXCEPTION_NONE -o hello2 hello.dats
size hello2
   text    data     bss     dec     hex filename
   1787     512      32    2331     91b hello2
```

[1]: https://groups.google.com/d/msg/ats-lang-users/NEJDC7yY9cw/IWeK_0YRhksJ
