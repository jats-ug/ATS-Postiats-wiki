## C言語ソースパッケージから ATS2 をコンパイルする

ATS の Web サイトでの [説明][1] を参考にしてください。

## github にホスティングされているソースコードから ATS2 をコンパイルする

このスタイルでの ATS2 コンパイルは、ATS2 の開発に参加することに興味のある人向けであることに注意してください。

ATS2 は ATS1 で実装されています。
現時点では、ATS2 (ATS/Postiats) をブートストラップするのに必要な ATS1 (ATS/Anairiats) のバージョンは
0.2.11 です。
以下の説明は、すでに ATS1-0.2.11 がインストールされていると仮定しています。

Postiats の [ソースコード][2] を zip ファイルとしてダウンロードするか、
次のコマンドを使ってチェックアウトしてください。
(`~/postiats` をローカルにチェックアウトしたリポジトリのディレクトリとしています):


    git clone https://github.com/githwxi/ATS-Postiats.git ~/postiats

~/postiats/bin ディレクトリを PATH に含めてください。
これはビルドプロセスの後半が生成された "patsopt" を使うためです。

そして ATS2 をビルドします:

```
make -f Makefile_devl all
```

このコマンドは実際には次も実行してくれます:

```
make -f codegen/Makefile_atslib # これは最初の make -f Makefile_devl を実行するときのみ必要です
```

必要なら、自分の PATH にも `~/postiats/bin` を含めてください。
例えば、次のような行を `.bashrc` に追加するでしょう:

    export PATH=${PATH}:${HOME}/postiats/bin

最後に、2つの環境変数を適切に設定する必要があります:

    export PATSHOME=${HOME}/postiats # このインストール例の場合です。もしくは ATS2 の位置を指定してください。

ats2-lang-contrib も使うのであれば、環境変数 PATSHOMERELOC に ats2-lang-contrib
が置かれたディレクトリの名前を設定してください。

## もし ATS/Postiats のビルドに失敗したら何をすべきでしょうか

どこかでビルドが失敗してしまうのであれば、クリーンアップする必要があるかもしれません:

    make -C src cleanall

それでもうまくいかない場合、ATSLIB もクリーンアップしてみてください:

    make -f codegen/Makefile_atslib cleanall

github リポジトリで更新された [ATSLIB] コードを使うときは、上記の make ターゲットを必ず実行すべきです。

## パッケージシステムを使って ATS をインストールする

### Debian GNU/Linux unstable(sid)

$ sudo apt-get install ats2-lang

## 仮想環境での ATS

ATS は次コマンドで docker コンテナにインストールすることができます:

```
docker run -ti -v [your source directory]:/src steinwaywhw/ats
```

docker さえインストールされていれば、どんなプラットフォームでもどんな ATS コードも編集/コンパイルできます。
さらなる情報と docker インストールファイルが https://github.com/steinwaywhw/docker-ats
から入手できます。

Vagrantfile をこの Dockerfile を元にして書くこともできます。
(コンテナの代わりに) 実際の仮想マシンで起動することもできるでしょう。

[1]: http://www.ats-lang.org/DOWNLOAD
[2]: https://github.com/githwxi/ATS-Postiats
