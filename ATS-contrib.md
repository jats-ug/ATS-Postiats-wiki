## Downloading ATS Contrib

Releases are currently available [[at sourceforge|https://sourceforge.net/projects/ats2-lang-contrib/]], though those developing libraries for ATS contrib should use the [[github repository|https://github.com/githwxi/ATS-Postiats-contrib]].


## Setting up ATS Contrib


An example of how to set up environment variables for ATS-contrib (alongside ATS):

```bash
export POSTIATS=${HOME}/research/Postiats/git
export POSTIATS_contrib=${HOME}/research/Postiats-contrib/git

######

export PATSHOME=${POSTIATS}
export PATSHOMERELOC=${POSTIATS_contrib}
```


## Using ATS Contrib

It may be the case that you want to contribute to an existing package, or create a new package that will gradually be
curated to be in the main `contrib` directory. User codes are generally put in a separate subdirectory of ATS contrib. For instance, there is a user directory `contrib/libats-/bbarker/OpenMP` for OpenMP, and a curated version of OpenMP in `contrib/OpenMP`.

In order to switch between using these various packages, [[atspkgreloc|atspkgreloc]] is a useful tool that may automate the process. It can additionally be used with other repositories or forms of code storage.