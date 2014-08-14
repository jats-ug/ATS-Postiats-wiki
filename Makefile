MD_ORIG      := $(wildcard *.md)
MD_JA        := $(patsubst %.md,ja/%.md,${MD_ORIG})
OPT_UPDATEPO := $(patsubst %.md,-m %.md,${MD_ORIG})

all: ${MD_JA}

updatepo: ${MD_ORIG}
	po4a-updatepo -M utf8 -f text ${OPT_UPDATEPO} -p po/ja.po

ja/%.md: %.md po/ja.po
	po4a-translate -M utf8 -f text -k 0 -m $< -p po/ja.po -l $@
