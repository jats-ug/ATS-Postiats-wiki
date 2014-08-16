MD_ORIG      := $(filter-out README.md,$(wildcard *.md))
MD_JA        := $(patsubst %.md,ja/%.md,${MD_ORIG})
OPT_UPDATEPO := $(patsubst %.md,-m %.md,${MD_ORIG})
ODGS := $(wildcard draw/*.odg)
PNGS := $(patsubst %.odg,%.png,${ODGS})

all: ${MD_JA} ${PNGS}

updatepo: ${MD_ORIG}
	po4a-updatepo -M utf8 -f text ${OPT_UPDATEPO} -p po/ja.po

ja/%.md: %.md po/ja.po
	po4a-translate -M utf8 -f text -k 0 -m $< -p po/ja.po -l $@

%.png: %.odg
	unoconv -n -f png -o $@.tmp $< 2> /dev/null   || \
          unoconv -f png -o $@.tmp $<                 || \
	  unoconv -n -f png -o $@.tmp $< 2> /dev/null || \
          unoconv -f png -o $@.tmp $<
	convert -resize 600x $@.tmp $@
	rm -f $@.tmp
