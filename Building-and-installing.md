## Compiling ATS2 from packaged C-source.

Please see the [directions][1] on the ATS site. 

## Compiling ATS2 from github-hosted source.

Please note that compiling ATS2 in this style is recommended
primarily for people who are interested in helping develop ATS2.

ATS2 is implemented in ATS1.
Currently, the required version of ATS1 (ATS/Anairiats) for bootstrapping ATS2 (ATS/Postiats) is 0.2.11.
Assume that you have already installed ATS1-0.2.11.

Checkout Postiats from [sources][2] by downloading the zip file or using the following command (assuming that `~/postiats` is a directory where the repository is to be put locally):


    git clone https://github.com/githwxi/ATS-Postiats.git ~/postiats

Set PATH to include the directory ~/postiats/bin so that the second half of the building process knows where to locate the created "patsopt".

Now, build ATS2:

```
make -f Makefile_devl all
```
This command effectively executes both of the following:

```
make -f codegen/Makefile_atslib # this is only needed for the first time
make -f Makefile_devl
```

Optionally, put `~/postiats/bin` on your PATH, e.g., by adding the following line to your `.bashrc`:

    export PATH=${PATH}:${HOME}/postiats/bin

Finally, a couple of environmental variables need to be properly set:

    export PATSHOME=${HOME}/postiats #For the example install above, or wherever ATS2 is located.

If you also want to use ats2-lang-contrib, then please set the environmental variable PATSHOMERELOC to
the name of the directory where ats2-lang-contrib resides.

## What to try if the build of ATS/Postiats fails

Should the build fail at some point, it may be necessary to clean up:

    make -C src cleanall

If that does not work, it is worth trying to clean up atslib as well:

    make -f codegen/Makefile_atslib cleanall

The above make rule should be executed whenever one wishes to use updated [atslib] code from the upstream github repository.

## ATS in a virtual machine

ATS can be installed in a docker container using the following command:

```
docker run -ti -v [your source directory]:/src steinwaywhw/ats 
```

This gives you the ability to edit/compile any ATS code on any platform as long as docker is installed.
More information and the docker install file is available at https://github.com/steinwaywhw/docker-ats. 

A Vagrantfile could be written based on that Dockerfile, which enables booting up a real virtual machine (instead of a container).

[1]: http://www.ats-lang.org/DOWNLOAD
[2]: https://github.com/githwxi/ATS-Postiats