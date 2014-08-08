**Template-related errors.**
Using a function template on a non-abstract type can result in this (the rules for templates are not all written down and the implementation is not finished):

    falcon_cnfize_dats.c: In function âATSLIB_056_prelude__list_vt_freelin__clear__7__1â:
    falcon_cnfize_dats.c:1698:1: error: âPMVtmpltcstmatâ undeclared (first use in this function)
    falcon_cnfize_dats.c:1698:1: note: each undeclared identifier is reported only once for each function     it appears in
    falcon_cnfize_dats.c:1698:1: error: âgclear_refâ undeclared (first use in this function)
    falcon_cnfize_dats.c:1698:1: warning: implicit declaration of function âS2EVarâ [-Wimplicit-function-declaration]
    falcon_cnfize_dats.c:1698:1: error: expected expression before â)â token
    exec(gcc -std=c99 -D_XOPEN_SOURCE -I/home/brandon/ATS-Postiats -I/home/brandon/ATS-Postiats/ccomp/runtime -I/home/brandon/ATS-Postiats/contrib -DATS_MEMALLOC_LIBC -D_GNU_SOURCE -c falcon_cnfize_dats.c) = 256

To avoid this, either don't use a template (for now), or try to use an abstract type:
    
    abstype mytype = ptr

Then you introduce cast functions where needed to convert between the abstract type and other (view)types.

**Missing Linker Flag Errors**

Forgot to properly pass -DATS_MEMALLOC_LIBC to patscc.

    /tmp/cchxHdy9.o: In function atspre_arrayptr_free':
    gurobi_mip1_dats.c:(.text+0x1d4): undefined reference toatsruntime_mfree_undef'
    /tmp/cchxHdy9.o: In function  _057_media_057_RAID5_057_home_057_brandon_057_ATS_055_Postiats_057_contrib_057_libats_055_bbarker_057_ats    optml_057_TEST_057_gurobi_mip1_056_dats__mytest_main':
    gurobi_mip1_dats.c:(.text+0x4dc): undefined reference toatsruntime_malloc_undef'
    gurobi_mip1_dats.c:(.text+0x54e): undefined reference to `atsruntime_malloc_undef'
    collect2: ld returned 1 exit status