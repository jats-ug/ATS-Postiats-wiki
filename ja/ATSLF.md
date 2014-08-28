ATS/LF ([論理フレームワーク](https://en.wikipedia.org/wiki/Logical_framework)) は
(対話的な) 定理証明をサポートしています; ATS
は構文的に融合した手法で定理証明とプログラミングを統合してプログラムを検証する、プログラマ中心のアプローチを指示しています。

## 公理, 証明, 定理

* 公理 (axiom) - `praxi`; 証明なしの定理を宣言します。
* 証明 (proof) - `prfn`; prfun の再帰しないバージョンです。
* 証明 (proof) - `prfun`; 証明を与えることが要求される定理を宣言します。現在の ATS2 ではこの要求は強制されず、prfun
  は実際には praxi と似た扱いになっています [\[1\]][1]。
* 定理 (theorem) - `prop`; 定理を表現する ATS の型を分類します。

証明関数は `primplement` キーワードを使って実装できる (もしくはその必要がある)
ことに注意してください。このキーワードは動的な関数を実装する際の `implement` に似ています。ATS2 Book により詳細な情報があります。


[1]:
https://groups.google.com/d/msg/ats-lang-users/enDXT0GaoaM/HKJcjCJSdoYJ)
