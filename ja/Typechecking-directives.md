* `$effmask_all` - 実際にはプログラミングの型の役に立たないような、関数の [作用](effects.md)
  の追跡を無視するよう型検査器に指示します。使う場合には `$effmask_all(...)` のように書き、`...`
  には関数呼び出しを記述します [\[1\]][1]。
* `$showtype` - 値や変数の型を ATS
  の内部の型表現で印字します。型エラーの理解に非常に有用ですが、複雑な場合にはその出力の正確な意味はまだ謎めいて見えるかもしれません。より詳しくは
  [内部の型](Internal-types.md) を参照してください。また [エラーメッセージ](Error-messages.md)
  にはその例があります。

[1]:
https://groups.google.com/forum/#!searchin/ats-lang-users/mask$20effect/ats-lang-users/yqldklykEuM/021vPg65v9gJ
