#
# Date:      2007/04/18 10:12
# Author:    Jan Faigl
#

-include $(MK_DIR)/paths.mk


PNG=$(wildcard *.png)
EPS=$(patsubst %.png,%.eps,$(wildcard *.png))
JPG=$(wildcard *.jpg)
EPS_JPG=$(patsubst %.jpg,%.eps,$(wildcard *.jpg))


PNG_EMPTY=$(addprefix $(PIC_EMPTY_DIR)/,$(PNG))
EPS=$(patsubst %.png,%.eps,$(wildcard *.png))

PIC_EMPTY_DIR=empty_pic
DEST_DIR=../../fig/
DEST_PNG=$(addprefix $(DEST_DIR),$(PNG))
DEST_JPG=$(addprefix $(DEST_DIR),$(JPG))
DEST_EPS=$(addprefix $(DEST_DIR),$(EPS))
DEST_EPS+=$(addprefix $(DEST_DIR),$(EPS_JPG))

ifndef EMPTY_PIC
targets=png
SOURCE_PNG=
else
targets=png_empty
PNG_DEP=png_empty
SOURCE_PNG=$(PIC_EMPTY_DIR)/
endif

copy_targets=copy_png copy_jpg

ifdef WITH_PS
targets+=eps
copy_targets+=copy_eps
endif


.PHONY: $(DEST_PNG) $(DEST_JPG)

all: $(targets)

eps: $(EPS) $(EPS_JPG)

$(EPS): %.eps: %.png
	$(convert_img_to_eps)

$(EPS_JPG): %.eps: %.jpg
	$(convert_img_to_eps)

png: $(PNG_DEP)

jpg:

clean:
	$(RM) $(EPS) $(EPS_JPG)
	$(RM) $(PIC_EMPTY_DIR)


png_empty: $(PIC_EMPTY_DIR) $(PNG_EMPTY)

$(PIC_EMPTY_DIR):
	$(MKDIR) $(PIC_EMPTY_DIR)

$(PNG_EMPTY):
	$(CONVERT) -size `$(IDENTIFY) -format "%wx%h" $(patsubst $(PIC_EMPTY_DIR)/%.png,%.png,$@)` xc:black $@

copy: $(copy_targets)



copy_png: png $(DEST_PNG)

$(DEST_PNG): $(DEST_DIR)%.png: %.png
	@$(ECHO) Start copy $(SOURCE_PNG)$< to $@$(shell $(TEST) -L $@ && $(UNLINK) $@ && $(ECHO) ", but remove existing link in $(DEST_DIR) at first") 
	@$(CP) $(SOURCE_PNG)$< $@

copy_jpg: jpg $(DEST_JPG)

$(DEST_JPG): $(DEST_DIR)%.jpg: %.jpg
	@$(ECHO) Start copy $< to $@$(shell $(TEST) -L $@ && $(UNLINK) $@ && $(ECHO) ", but remove existing link in $(DEST_DIR) at first") 
	@$(CP) $< $@

copy_eps: eps $(DEST_EPS)

$(DEST_EPS): $(DEST_DIR)%.eps: %.eps
	@$(ECHO) Start copy $< to $@$(shell $(TEST) -L $@ && $(UNLINK) $@ && $(ECHO) ", but remove existing link in $(DEST_DIR) at first") 
	@$(CP) $< $@
