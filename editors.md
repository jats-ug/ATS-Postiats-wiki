Several editors support ATS(2). 

## Emacs
* ATS2-mode supports syntax highlighting of ATS and embedded C code. For download, see the [official repository](https://github.com/mrd/ats2-mode) or possible forks ([1](https://github.com/githwxi/ATS-Postiats-contrib/blob/master/contrib/libats-/bbarker/emacs/ats2-mode.el), [2](../tree/master/utils/emacs/ats2-mode.el)).
* ATS2-flymake depends on ATS2-mode. It is available [with ATS2/Postiats](../tree/master/utils/emacs/ats2-flymake.el). It can highlight the location of the source of a type-error pretty well but it may have some room for improvement. Currently, one can use ` C-x `` (that is backquote) to locate the source
of a type-error. Basically, you can do the following (with ats2-mode for emacs being turned on):

```
C-c C-c // for compilation
C-x `     // for locating the source of the first error
C-x `     // for locating the source of the next error
```

## Vim 
There is existing code for a vim mode, but most of the ATS users seem to use emacs. See [this issue](https://github.com/githwxi/ATS-Postiats/issues/30) for a full discussion and code links.

## SublimeText
This is just a syntax highlight file, not a full mode. You can install it at the [Package Control](https://sublime.wbond.net/packages/ATS%20Syntax%20Highlight). 
