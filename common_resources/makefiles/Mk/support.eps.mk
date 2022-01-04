#
# Date:      2007/06/25 15:46
# Author:    Jan Faigl
#
# Makefile to support generating figures from eps files 

-include $(MK_DIR)/paths.mk

EPS=$(wildcard *.eps)
PDF=$(patsubst %.eps,%.pdf,$(wildcard *.eps))

DEST_DIR=../../fig/

CZECHFILE="cestina.txt"

copy_targets=copy_pdf

ifdef WITH_PS
targets+=eps 
pdf_target=pdf_from_eps
copy_targets+=copy_eps
else
pdf_target=pdf_only
endif


DEST_PDF=$(addprefix $(DEST_DIR),$(PDF))
DEST_EPS=$(addprefix $(DEST_DIR),$(EPS))

targets+=$(pdf_target)

all: $(targets)

eps: $(EPS)

pdf: $(pdf_target)

pdf_only: $(PDF)

pdf_from_eps: $(EPS) $(PDF)

%.pdf: %.eps
	$(EPS2PDF) $<

clean:
	$(RM) $(PDF)

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
