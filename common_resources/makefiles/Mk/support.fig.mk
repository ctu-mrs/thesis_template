#
# Date:      2007/04/18 10:14
# Author:    Jan Faigl
#
# Makefile to support generating figures from fig (xfig) files 

-include $(MK_DIR)/paths.mk

FIG=$(wildcard *.fig)
EPS=$(patsubst %.fig,%.eps,$(wildcard *.fig))
PDF=$(patsubst %.fig,%.pdf,$(wildcard *.fig))

DEST_DIR=../../fig/


ifdef WITH_PS
targets+=eps 
targets+=pdf
copy_targets+=copy_pdf
copy_targets+=copy_eps
else
targets=pdf
copy_targets+=copy_pdf
endif


DEST_PDF=$(addprefix $(DEST_DIR),$(PDF))
DEST_EPS=$(addprefix $(DEST_DIR),$(EPS))

all: $(targets)

eps: $(EPS)

pdf: $(PDF)

%.eps: %.fig
	$(FIGURECMD) -L eps $< $@

%.pdf: %.fig
	$(FIGURECMD) -L pdf $< $@

clean:
	$(RM) $(EPS) $(PDF)

.PHONY: $(DEST_PDF) $(DEST_EPS)

copy: $(copy_targets)

copy_pdf: pdf $(DEST_PDF)

copy_eps: eps $(DEST_EPS)

$(DEST_PDF): $(DEST_DIR)%.pdf: %.pdf
	@$(ECHO) Start copy $< to $@$(shell $(TEST) -L $@ && $(UNLINK) $@ && $(ECHO) ", but remove existing link in $(DEST_DIR) at first") 
	@$(CP) $< $@

$(DEST_EPS): $(DEST_DIR)%.eps: %.eps
	@$(ECHO) Start copy $< to $@$(shell $(TEST) -L $@ && $(UNLINK) $@ && $(ECHO) ", but remove existing link in $(DEST_DIR) at first") 
	@$(CP) $< $@
