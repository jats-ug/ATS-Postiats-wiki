The first (and so far only) translation effort for ATS content is in
Japanese. There is a workflow for translating the wiki and keeping it up to
date using [po4a](http://po4a.alioth.debian.org/).

![Image of Wiki Internationalization
Workflow](https://raw.githubusercontent.com/jats-ug/ATS-Postiats-wiki/translate_ja/draw/translate_flow.png)

In the above workflow (and the example below of executing the workflow),
"ja" is the directory for end-result of the translated wiki. The repository
for the Japanese wiki is located at
https://github.com/jats-ug/ATS-Postiats-wiki/.

## Example run

### Git pull upstream master

```
$ pwd
/home/kiwamu/doc/ATS-Postiats-wiki.jats-ug
$ git branch -a
* master
  translate_ja
  remotes/origin/HEAD -> origin/master
  remotes/origin/master
  remotes/origin/translate_ja
  remotes/upstream/master
$ grep -C 1 url .git/config
[remote "origin"]
        url = git@github.com:jats-ug/ATS-Postiats-wiki.git
        fetch = +refs/heads/*:refs/remotes/origin/*
--
[remote "upstream"]
        url = https://github.com/githwxi/ATS-Postiats.wiki.git
        fetch = +refs/heads/*:refs/remotes/upstream/*
$ git pull upstream master
remote: Counting objects: 3, done.
remote: Compressing objects: 100% (3/3), done.
remote: Total 3 (delta 2), reused 0 (delta 0)
Unpacking objects: 100% (3/3), done.
From https://github.com/githwxi/ATS-Postiats.wiki
 * branch            master     -> FETCH_HEAD
   8fb40af..f410a52  master     -> upstream/master
Updating c578a11..f410a52
Fast-forward
 ATS-LF.md => ATSLF.md                                               |
10 +++++-----
 Building-and-installing.md                                          |  4 ++--
 contrib.md => Contrib.md                                            |  6 ++----
 ATS-Libraries-and-C-Library-bindings.md => Contributed-Libraries.md |  0
 TODO.md                                                             |  2 ++
 atsdoc.md                                                           |  5 ++++-
 atslib.md                                                           |  2 +-
 7 files changed, 16 insertions(+), 13 deletions(-)
 rename ATS-LF.md => ATSLF.md (55%)
 rename contrib.md => Contrib.md (93%)
 rename ATS-Libraries-and-C-Library-bindings.md =>
Contributed-Libraries.md (100%)
```

### Git merge changes into translate_ja

```
$ git branch
* master
  translate_ja
$ git checkout translate_ja
Switched to branch 'translate_ja'
Your branch is up-to-date with 'origin/translate_ja'.
$ git merge master
Auto-merging Contrib.md
Auto-merging ATSLF.md
Merge made by the 'recursive' strategy.
 ATS-LF.md => ATSLF.md                                               |
10 +++++-----
 Building-and-installing.md                                          |  4 ++--
 contrib.md => Contrib.md                                            |  6 ++----
 ATS-Libraries-and-C-Library-bindings.md => Contributed-Libraries.md |  0
 TODO.md                                                             |  2 ++
 atsdoc.md                                                           |  5 ++++-
 atslib.md                                                           |  2 +-
 7 files changed, 16 insertions(+), 13 deletions(-)
 rename ATS-LF.md => ATSLF.md (55%)
 rename contrib.md => Contrib.md (93%)
 rename ATS-Libraries-and-C-Library-bindings.md =>
Contributed-Libraries.md (100%)
```

### Updatepo

``` $ make updatepo po4a-updatepo -M utf8 -f text -m compiler-errors.md -m
Scientific-Computing.md -m Built-in-operators.md -m
Building-and-installing.md -m Internal-types.md -m tutorials.md -m
Strings.md -m safety.md -m ATSLF.md -m Stack-and-heap-allocation.md -m
Rosetta-Stone.md -m atslib.md -m Home.md -m code-generation.md -m
typechecking-errors.md -m Contributed-Libraries.md -m FAQ.md -m
dataviewtype.md -m runtime-errors.md -m staload.md -m
Built-in-constraint-solving.md -m overload.md -m char.md -m Memory-leaks.md
-m Typechecking-directives.md -m README.md -m type.md -m effects.md -m
atspkgreloc.md -m Built-in-datatypes.md -m TODO.md -m loops.md -m dynload.md
-m Error-messages.md -m Code-optimization.md -m sort.md -m
Frequently-asked-questions.md -m atsdoc.md -m template.md -m Contrib.md -m
Compiling-ATS-code.md -m Style-guide.md -p po/ja.po
........................................................................
done.  $ git diff|tail -20

 #. type: Plain text
-#: char.md:37
-#, no-wrap
+#: Contrib.md:25
 msgid ""
-"```ocaml\n"
-"(*\n"
-"   HX: the return is dynamically allocated\n"
-"*)\n"
-"fun tostring_char\n"
-"  (c: char):<> strnptr(1) = \"mac#%\"\n"
-"overload tostring with tostring_char\n"
-"```\n"
+"In order to switch between using these various packages, [[atspkgreloc|"
+"atspkgreloc]] is a useful tool that may automate the process. It can "
+"additionally be used with other repositories or forms of code storage."
 msgstr ""

 #. type: Plain text
```

### Translate using gettext

```
$ make
po4a-translate -M utf8 -f text -k 0 -m compiler-errors.md -p po/ja.po
-l ja/compiler-errors.md
po4a-translate -M utf8 -f text -k 0 -m Scientific-Computing.md -p
po/ja.po -l ja/Scientific-Computing.md
po4a-translate -M utf8 -f text -k 0 -m Built-in-operators.md -p
po/ja.po -l ja/Built-in-operators.md
--snip--
po4a-translate -M utf8 -f text -k 0 -m Contrib.md -p po/ja.po -l ja/Contrib.md
po4a-translate -M utf8 -f text -k 0 -m Compiling-ATS-code.md -p
po/ja.po -l ja/Compiling-ATS-code.md
po4a-translate -M utf8 -f text -k 0 -m Style-guide.md -p po/ja.po -l
ja/Style-guide.md
$ git status
On branch translate_ja
Your branch is ahead of 'origin/translate_ja' by 21 commits.
  (use "git push" to publish your local commits)
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

        modified:   ja/Building-and-installing.md
        modified:   ja/Frequently-asked-questions.md
        modified:   ja/TODO.md
        modified:   ja/atsdoc.md
        modified:   ja/atslib.md
        modified:   po/ja.po

Untracked files:
  (use "git add <file>..." to include in what will be committed)

        ja/ATSLF.md
        ja/Contrib.md
        ja/Contributed-Libraries.md

no changes added to commit (use "git add" and/or "git commit -a")  $ git
diff ja/Building-and-installing.md | tail +If that does not work, it is
worth trying to clean up ATSLIB as well:

     make -f codegen/Makefile_atslib cleanall

 The above make rule should be executed whenever one wishes to use updated
-[atslib] code from the upstream github repository.
+[ATSLIB] code from the upstream github repository.

 ## ATS in a virtual machine
```

### Publish it

```
$ git add .
$ git commit -m update
[translate_ja 4c55ee8] update
 9 files changed, 466 insertions(+), 293 deletions(-)
 create mode 100644 ja/ATSLF.md
 create mode 100644 ja/Contrib.md
 create mode 100644 ja/Contributed-Libraries.md
$ git push
Counting objects: 58, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (57/57), done.
Writing objects: 100% (58/58), 11.82 KiB | 0 bytes/s, done.
Total 58 (delta 35), reused 0 (delta 0)
To git@github.com:jats-ug/ATS-Postiats-wiki.git
   1c3b274..4c55ee8  translate_ja -> translate_ja
```
