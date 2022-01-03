#
# Data:		2006/04/19 12:00
# Author:	Jan Faigl
#
# General Makefile

ifdef MK_DIR
-include $(MK_DIR)/paths.mk
else
-include ../Mk/paths.mk
-include ../../Mk/paths.mk
endif

LATEXPDFTESTFLAGS=-halt-on-error -file-line-error

MAKECONFIG="makeconfig.tex"
ifeq ($(PRINT),yes)
CONFIGURATIONS+="\let\print=1"
endif

ifeq ($(NO_COLOR_LINKS),yes)
CONFIGURATIONS+="\def\clinks{false}"
endif


SUPPORTDIR = support

DEPENDS+=
DEPENDS+=pre-build

ifdef WITH_PS
name_target=ps
else
name_target=pdf
endif

$(NAME): $(name_target)

ps:  dvi $(DEPENDS)
	$(DVI2PS) $(NAME).dvi -o $(NAME).ps

dvi:	pic $(DEPENDS) $(SOURCE_FILES)
	$(LATEX) $(NAME)

pdf:	pic $(DEPENDS) $(SOURCE_FILES)
	$(LATEXPDF) $(NAME)

buildtest: pic $(DEPENDS)
	$(LATEXPDF) $(LATEXPDFTESTFLAGS) $(NAME) >$(LOG_FILE)

$(NAME).aux:
	$(LATEX)  $(NAME)

bib:	$(NAME).aux
	$(BIBTEX) $(NAME)

glossaries: $(NAME).aux
	makeglossaries $(NAME)

idx:	$(NAME).idx

$(NAME).idx: $(NAME).ilg
	$(MAKEINDEX) $(NAME)

$(NAME).ilg:
	$(LATEX) $(NAME)


all:   ps pdf

pre-build: PRE_BUILD_CMD=$(MAKE) -C $@
pre-build: $(PRE_BUILD)

pre-build-clean: PRE_BUILD_CMD=$(MAKE) -C $@ clean
pre-build-clean: $(PRE_BUILD)

$(PRE_BUILD):
	$(PRE_BUILD_CMD)

pic: fig/.done	

fig/.done:
	$(MAKE) -C $(SUPPORTDIR)/ copy
	$(TOUCH) fig/.done

docarc:
	$(CP) $(NAME).aux $(DOCARC_TMP).aux
	$(DOCARC_CMD) -b $(DOCARC_BPPATH) fetch $(DOCARC_TMP)
	$(MV) $(DOCARC_TMP).bib $(NAME).bib
	$(RM) $(DOCARC_TMP).aux

TEX_SOURCES=$(wildcard *.tex)

.PHONY: $(PRE_BUILD)


clean: cleanmakeconfig pre-build-clean
	$(RM) *~ *# *.log *.aux *.toc *.dvi *.gz core *.ps main.pdf
	$(RM) *.bbl *.blg *.lol *.lof *.lot *.fls *.idx *.ilg *.ind *.out *.nav *.snm *.tbd *.fdb_latexmk *.glo-abr *.acn *.acr *.alg *-blx.bib *.glg *.glo *.gls *.ist *.run.xml #$(RM) fig/*.png fig/*.eps fig/*.pdf fig/*.jpg  
	$(RM) ./src/*.fdb_latexmk ./src/*.log ./src/*.fls ./src/*.aux
	$(RM) fig/.done

cleanmakeconfig: 
	$(RM) makeconfig.tex

cleanall: clean cleanmakeconfig
	$(MAKE) -C $(SUPPORTDIR)/ clean
	$(RM) *.snm *.out *.nav fig/.done

config: configure version

configure:
	@$(ECHO) "configure $(MAKECONFIG)"
	@$(ECHO) $(CONFIGURATIONS) > $(MAKECONFIG)

glreport: 
	$(MAKE) BUILD_GLREPORT=yes config
	$(MAKE) BUILD_GLREPORT=yes

version: configure $(TEX_SOURCES)
	@$(ECHO) "Retrieve directory SVN Revision"
	@$(ECHO) "\newcommand{\SVNRevision}{" >> $(MAKECONFIG)
	@$(SVN_INFO) | $(GREP) "Last Changed Rev" | $(AWK) -v FS=: '{print "Revision" $$2}' >> $(MAKECONFIG)
	@\$(ECHO) "}" >> $(MAKECONFIG)
