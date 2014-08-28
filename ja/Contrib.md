## contrib のダウンロード

ATS contrib のリリース版は [sourceforge
にあり](https://sourceforge.net/projects/ats2-lang-contrib/)、開発版ライブラリを使うには
[github リポジトリ](https://github.com/githwxi/ATS-Postiats-contrib) を参照してください。

## contrib の設定

(ATS と一緒に) ATS-contrib を使うための環境変数の設定例です:

```bash
export POSTIATS=${HOME}/research/Postiats/git
export POSTIATS_contrib=${HOME}/research/Postiats-contrib/git

######

export PATSHOME=${POSTIATS} export PATSHOMERELOC=${POSTIATS_contrib}
```


## ATS contrib を使用する

既存のパッケージに貢献したくなる場合があるでしょう。もしくは新しいパッケージを作って、徐々にメインの `contrib`
ディレクトリに監督/配置したいかもしれません。一般にユーザコードは ATS contrib
の切り離されたサブディレクトリに配置します。例えば、OpenMP ためのユーザディレクトリ
`contrib/libats-/bbarker/OpenMP` と、`contrib/OpenMP` にOpenMP
の監督されたバージョンがあります。

これらの様々なパッケージの使用を切り換えるために、[atspkgreloc](atspkgreloc.md)
は有用なツールで、このプロセスを自動化できます。さらに他のリポジトリやコードストレージのようなものを使うこともできます。
