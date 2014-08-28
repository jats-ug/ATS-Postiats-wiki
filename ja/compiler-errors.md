## テンプレートに関連したエラー

**テンプレート実装を読み込んでいない**
このエラーは次のようなものです:

```
// gcc
'XXX' undeclared (first use in this function)
expected expression before ‘YYY’
```

ATS2 で一般的に使用される多くの標準的なテンプレート実装があり、それらはデフォルトでは読み込まれません。(例えば、kernel
や組み込みプログラミングでは、必要ないものは読み込まないべきでしょう。) 通常、この問題はファイルの先頭に次の行を追加すれば解決します:

```ocaml
#include "share/atspre_staload.hats"
```

通常、ATS コンパイラはテンプレート実装を除く [prelude](ATSLIB.md) のみを [staload](staload.md)
します。これが ATS 初心者を混乱させるよくある原因です。

**抽象型でないテンプレート関数**

抽象型ではない関数テンプレートは次のようなエラーを生じることがあります。(テンプレートの規則は完全に書き起こされていませんし、またその実装も完了していません。):

    falcon_cnfize_dats.c: In function âATSLIB_056_prelude__list_vt_freelin__clear__7__1â:
    falcon_cnfize_dats.c:1698:1: error: âPMVtmpltcstmatâ undeclared (first use in this function)
    falcon_cnfize_dats.c:1698:1: note: each undeclared identifier is reported only once for each function     it appears in
    falcon_cnfize_dats.c:1698:1: error: âgclear_refâ undeclared (first use in this function)
    falcon_cnfize_dats.c:1698:1: warning: implicit declaration of function âS2EVarâ [-Wimplicit-function-declaration]
    falcon_cnfize_dats.c:1698:1: error: expected expression before â)â token
    exec(gcc -std=c99 -D_XOPEN_SOURCE -I/home/brandon/ATS-Postiats -I/home/brandon/ATS-Postiats/ccomp/runtime -I/home/brandon/ATS-Postiats/contrib -DATS_MEMALLOC_LIBC -D_GNU_SOURCE -c falcon_cnfize_dats.c) = 256

この問題を回避する方法は、(現時点では) テンプレートの使用をあきらめるか、抽象型を使ってみることです:
    
    abstype mytype = ptr

それから、その抽象型と別の(観)型とを変換するのに必要なキャスト関数を導入してください。

## リンカフラグの不足によるエラー

**メモリ確保関数の使用を指定していない**

通常この問題の解決策は -DATS_MEMALLOC_LIBC を patscc に適切に渡すことでしょう。ここで見られるエラーは主に
`undefined reference to `atsruntime_malloc_undef'` です。(通常このエラーは複数回発生します。)

    /tmp/cchxHdy9.o: In function atspre_arrayptr_free':
    gurobi_mip1_dats.c:(.text+0x1d4): undefined reference toatsruntime_mfree_undef'
    /tmp/cchxHdy9.o: In function  _057_media_057_RAID5_057_home_057_brandon_057_ATS_055_Postiats_057_contrib_057_libats_055_bbarker_057_ats    optml_057_TEST_057_gurobi_mip1_056_dats__mytest_main':
    gurobi_mip1_dats.c:(.text+0x4dc): undefined reference toatsruntime_malloc_undef'
    gurobi_mip1_dats.c:(.text+0x54e): undefined reference to `atsruntime_malloc_undef'
    collect2: ld returned 1 exit status

よりカスタマイズしたい場合には [スタックとヒープへのメモリ確保](Stack-and-heap-allocation.md) を参照してください。
