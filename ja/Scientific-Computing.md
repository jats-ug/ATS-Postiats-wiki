ATS には、科学計算を実際的に有用に [安全に](safety.md)
するための多くのしくみがあります。この言語が安全性と効率にフォーカスしていることは明らかですが、実際に効果的な科学計算コードを作るのはしばしば
(どのような言語よりも) はるかに簡単です。

## Parallel programming

*
[OpenMP](https://github.com/githwxi/ATS-Postiats-contrib/tree/master/contrib/OpenMP)
共有メモリシステムにおいて [Open Multi-Processing](https://en.wikipedia.org/wiki/Openmp)
の使用を支援します。
*
[MPI](https://github.com/githwxi/ATS-Postiats-contrib/tree/master/contrib/MPI)
共有もしくは分散メモリシステムにおいて [Message Passing
Interface](https://en.wikipedia.org/wiki/Message_Passing_Interface)
の使用を支援します。

## 最適化

* 線形な凸最適化: [Gurobi
インターフェイス](https://github.com/githwxi/ATS-Postiats-contrib/tree/master/contrib/gurobi)

## Python [コード生成](code-generation.md)

R 言語が (特に生物学に関連する) 統計ソフトウェアをリードしていますが、Python は MATLAB
と並んで、おそらくもっとも人気のある科学計算言語の1つでしょう。

## 行列操作

効率的な行列操作は実際には困難です。

### ATS2 ネイティブの行列代数実装

### BLAS インターフェイス

(まだない？)

### ベンチマーク
