内部の型は `pats_staexp2.sats` ファイルで導入されています。これらの型がどのように実際の ATS
の型に結び付いているのか理解することは [デバッグの役に立つ](Error-messages.md) でしょう。

* `S2Eapp` - 関数適用の項
* `S2Ecst` - 型定数 (例: int, bool, list, など)
* `S2Eeff` - 関数の作用
* `S2Eexi` - 存在量化された型
* `S2Eint` - マシン精度整数
* `S2Eintinf` - 任意精度整数; atsopt (patsopt) のほとんどのバージョンにおいて整数種として一般に利用されます
* `S2Evar` - (一般に全勝量化された) 変数
* `S2Etop (0; T)` は `T?` を意味します `//Need to verify in ATS2`
* `S2Etop (1; T)` は `T?!` を意味します `//Need to verify in ATS2`
* `S2EVar` - 型検査器によって導入された (存在量化された) ユニフィケーション変数
