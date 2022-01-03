#
# Date:      2007/06/25 15:37
# Author:    Jan Faigl
#

-include $(MK_DIR)/paths.mk

DIA=$(wildcard *.dia)
EPS=$(patsubst %.dia,%.eps,$(wildcard *.dia))
PDF=$(patsubst %.dia,%.pdf,$(wildcard *.dia))

DEST_DIR=../../fig/

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

%.eps: %.dia
	$(DIA_CMD) --export=$@ $<

pdf_only: $(PDF)

pdf_from_eps: $(EPS) $(PDF)


%.pdf: %.eps
	$(EPS2PDF) $<

%.pdf: %.dia
	$(DIA_CMD) --export=$(basename $@).eps $<
	$(EPS2PDF) $(basename $@).eps
	$(RM) $(basename $@).eps

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
