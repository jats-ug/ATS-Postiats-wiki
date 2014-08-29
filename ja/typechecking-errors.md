## エラーメッセージを読む

おそらく ATS
初心者が遭遇するほとんどの一般的なエラーは型検査エラーでしょう。このため最初の段階では、それほど難しくない型検査のエラーメッセージを読めるようになることで、型検査のエラーメッセージに慣れることが重要です。はじめはそのようなエラーメッセージが古臭く感じるかもしれませんが、[簡単な方法はありません](https://groups.google.com/d/msg/ats-lang-users/-zsdyZWglRs/SUZt89SjYNcJ)。またもちろん経験をつめばエラーメッセージが読めるようになります。

例えば、次のコードの行は...

```ocaml
val () = assertloc (sum = showtype(1+2+3+4+5.0))
```

次のようなメッセージを引き起します:

```
/tmp/abcde.dats: 357(line=27, offs=10) -- 394(line=27, offs=47): error(3):
the symbol [=] cannot be resolved as no match is found.
/tmp/abcde.dats: 357(line=27, offs=10) -- 394(line=27, offs=47): error(3):
[/home/hwxi/research/Postiats/git/src/pats_trans3_util.dats]: d3exp_trdn:
the dynamic expression cannot be assigned the type
[S2Eapp(S2Ecst(bool_bool_t0ype); S2EVar(10))].
/tmp/abcde.dats: 357(line=27, offs=10) -- 394(line=27, offs=47): error(3):
mismatch of static terms (tyleq):
```

これは次のような意味です:

1. オーバロードされた演算子 = を解決できません
2. コンパイラが次の式にエラー型 (S2Eerr) を割り当てます: sum = showtype(1+2+3+4+5.0)
3. S2Eapp(S2Ecst(bool_bool_t0ype); S2EVar(10)) は bool_bool_t0ype(...) を表わします
4. assertloc は bool_bool_t0ype(...) 型の値を要求しているにもかかわらず、エラー型 (S2Eerr)
   の値が与えられています。


## $showtype demonstration

値の型を印字する `$showtype` 命令は非常に有用なツールです。 **ATS でプログラミングするとき、この命令はコード中の *どのような*
式の型も教えてくれます。そうでなければ、型エラーメッセージがどんなに飾りたてられても、迷子になってしまうでしょう。** 例えば、次はその単純な例です:

```ocaml
val x = 7 val _ = $showtype x

val y = ref<int> 7
val _ = $showtype y
val _ = $showtype !y
```

私達は `!y` と `x` が同じ型だろうと考えるかもしれません。型検査器を実行するときの `$showtype`
の出力で、これを確認することができます:

    **SHOWTYPE**(/home/myhome/showtype_test.dats: 143(line=12, offs=19) -- 144(line=12, offs=20)): S2Eapp(S2Ecst(g1int_int_t0ype); S2Ecst(int_kind), S2Eintinf(7))
    **SHOWTYPE**(/home/myhome/showtype_test.dats: 183(line=15, offs=19) -- 184(line=15, offs=20)): S2Eapp(S2Ecst(ref_vt0ype_type); S2Eapp(S2Ecst(g0int_t0ype); S2Ecst(int_kind)))
    **SHOWTYPE**(/home/myhome/showtype_test.dats: 203(line=16, offs=19) -- 205(line=16, offs=21)): S2Eapp(S2Ecst(g0int_t0ype); S2Ecst(int_kind))


より簡潔には、

``` type of x: S2Eapp(S2Ecst(g1int_int_t0ype); S2Ecst(int_kind),
S2Eintinf(7))  type of y: S2Eapp(S2Ecst(ref_vt0ype_type);
S2Eapp(S2Ecst(g0int_t0ype); S2Ecst(int_kind)))  type of !y:
S2Eapp(S2Ecst(g0int_t0ype); S2Ecst(int_kind))  ```

これで私達は先程の仮定が間違っていることを理解できました。新しい値 `z` を試してみましょう:

```ocaml
val z = ref<int(7)> 7
val _ = $showtype !z
````

````
type of !z: S2Eapp(S2Ecst(g1int_int_t0ype); S2Ecst(int_kind), S2Eintinf(7))
```

この結果は `!z` が `x` と同じ型であることを示しています。またこれは `x` の場合のように、整数はデフォルトでは ATS
の値でパラメータ化された型を持っていることを示しています。

### 関連項目

[内部の型](Internal-types.md) は `S2Eapp`, `S2Ecst`,
などを理解するのに役立ちます。それらエラーメッセージにしばしば見られます。

[1]: https://sourceforge.net/p/ats-lang/wiki/Error%20messages/

## 制約ソルバの制限

### 型検査器へ静的な値を与える

`unsolved constraint: C3NSTRprop` メッセージを表示すべきです。

In some rare cases, it may be necessary to supply a static value (if a
singleton type will do) to the typechecker, as the constraint solver may not
be able to infer the constraints. For instance, here is an example below
where the typechecker can't solve for an integer `x` such that `2x = 2`
([Fourier-Motzkin
elimination](https://en.wikipedia.org/wiki/Fourier%E2%80%93Motzkin_elimination)
is for linear inequalities, so this integer equality proves to be more
difficult and is currently unsupported by the solver). We can get around
this by suggesting that a valid value for static `x` in the `DubInt` type
below, when `2x = 2`, is `1`, and we supply `1` explicitly:

```ocaml typedef Int = [x:int] int(x)  typedef IntGT0 = [x:nat] int(x)
typedef DubInt = [x:int] int(2*x)

fun fun1 (x: Int): void = ()

fun funGT0 (x: IntGT0): void = ()

fun dubx(x: DubInt): void = ()

implement main0 () = { val x1:int(1) = 1 val x2:int(2) = 2

(* These are fine *)  val () = fun1(x1)  val () = funGT0(x1)

(* This would produce an unsolved constraint due to equality constraint:

val () = dubx(x2)

Instead we can do: *)

val () = dubx(#[ 1 | x2])  } ```

Another case may happen when we aren't able to supply the type implicitly
since no constraints on the type are generated. In such a case, supplying a
static value will work:

```ocaml
datatype
either_t0ype_bool_type
(
  a:t@ype+, b:t@ype+, bool

) =
  | Left (a, b, true) of (a)
  | Right (a, b, false) of (b)

stadef either = either_t0ype_bool_type typedef either (a:t0p, b:t0p) =
[c:bool] either(a, b, c)


fn{ a,b:t0p } either_left (a:a):<> either(a, b, true) = Left(a)

fn{ a,b:t0p } either_right (b:b):<> either(a, b, false) = Right(b)


fun do_either(x : int)
  : [n:nat; m:nat] either (int n, int m) =
  (* This would fail to typecheck due to unknown static values (i.e. types) 
     for 'b' and 'a' in either(_,b,_) and either(a,_,_) respectively:
  if x > 0 then either_left(0) else either_right(1)                   
  
  Instead we can do:                                                    *)
  if x > 0 then #[0,1 | either_left(0)] else #[0,1 | either_right(1)]

implement main0() = ignoret(do_either(~1))  ```

##Template-related errors##


- The template is expected to be fully applied but it is not.

This error will pop up from leaving out a template argument in some form,
and it is often the case (especially for beginners), that they've put the a
template argument on the wrong side of the function name.
