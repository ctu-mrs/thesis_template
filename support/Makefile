SUBDIRS+=fig
SUBDIRS+=pic
#SUBDIRS+=dia
#SUBDIRS+=eps
SUBDIRS+=pdf

.PHONY: subdirs $(SUBDIRS) copy clean 

ifeq ($(origin MAKECMDGOALS), undefined)
MAKECMDGOALS = all
endif

subdirs: $(SUBDIRS)

$(SUBDIRS):
	echo "Generate $(MAKECMDGOALS) in $@"
	$(MAKE) -C $@ $(MAKECMDGOALS)

generate: subdirs

clean: subdirs

copy: subdirs

all: generate copy
