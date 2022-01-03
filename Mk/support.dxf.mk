#
# Date:      2007/06/30 16:05
# Author:    Miroslav Kulich
#
# Makefile to support generating figures from xdf (CAD) files 

-include $(MK_DIR)/paths.mk

DXF=$(wildcard *.dxf)
EPS=$(patsubst %.dxf,%.eps,$(wildcard *.dxf))
PDF=$(patsubst %.dxf,%.pdf,$(wildcard *.dxf))
PS=$(patsubst %.dxf,%.ps,$(wildcard *.dxf))

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

%.eps: %.dxf
	$(DXF_CONVERT) $< $(basename $@).ps
	$(PS2EPSI) $(basename $@).ps $(basename $@).eps
	$(RM) $(basename $@).ps

pdf_only: $(PDF)

pdf_from_eps: $(EPS) $(PDF)


%.pdf: %.eps
	$(EPS2PDF) $<

%.pdf: %.dxf
	$(DXF_CONVERT) $< $(basename $@).ps
	$(PS2EPSI) $(basename $@).ps $(basename $@).eps
	$(RM) $(basename $@).ps
	$(EPS2PDF) $(basename $@).eps
	$(RM) $(basename $@).eps

clean:
	$(RM) $(EPS) $(PDF) $(PS)

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
