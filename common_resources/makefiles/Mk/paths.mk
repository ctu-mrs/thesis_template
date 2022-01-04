#
# Date:      2007/04/18 10:13
# Author:    Jan Faigl
#

# Global definition of CMD used in document build framework
# default values can be redefined in path.local.mk
#

#
# FILESYSTEM AND FILE TOOLS
#
MKDIR=mkdir
COMPRESS = gzip
SYMLINK=ln -s
UNLINK=unlink
RM=rm -fr
MV=mv
CP=cp
TOUCH=touch

#
# OTHER SYST TOOLS
#
ECHO=echo
GREP=grep
AWK=awk
TEST=test
SVN=svn
SVN_INFO=svn info
SVN_LOOK=svnlook
#
# LATEX TOOLS
#
LATEX	= latex
LATEXPDF = pdflatex
BIBTEX	= bibtex
DVI2PS	= dvips
MAKEINDEX = makeindex

#
# DOCARC TOOLS
#
DOCARC_CMD=$(HOME)/programy/docarc/docarc-client-1.0.2/docarc
DOCARC_BPPATH=$(HOME)/programy/docarc/docarc-client-1.0.2/bp
DOCARC_TMP=docarc_tmp



#
# SUPPORT TOOLS

CONVERT=convert
IDENTIFY=identify
FIGURECMD=fig2dev
EPS2PDF=epstopdf
PDF2EPS=pdftops -eps
CPCXFIG=cpcxfig
DIA_CMD=dia
PS2EPSI=ps2epsi
DXF_CONVERT=vec2web 

define xslt-processing
saxon $(XML) $(XSLT)
endef

#TEST_LINK_EXISTS=test -L
#TEST_LINK_NO_EXISTS=test ! -L

define common-fig-link
-if $(TEST) -L $(addprefix fig/,$@); then $(UNLINK) $(addprefix fig/,$@); fi;\
if $(TEST) ! -L $(addprefix fig/,@); then $(SYMLINK) ../$(COMMON_FIGURES)/$@ fig/; fi
endef

define common-fig-clean
-if -L $(addprefix fig/,$@); then $(UNLINK) $(addprefix fig/,$@); fi;
endef

define common-lst-link
-if $(TEST) -L $(addprefix lst/,$@); then $(UNLINK) $(addprefix lst/,$@); fi;\
if $(TEST) ! -L $(addprefix lst/,@); then $(SYMLINK) ../$(COMMON_LST)/$@ lst/; fi
endef

define common-lst-clean
-if -L $(addprefix lst/,$@); then $(UNLINK) $(addprefix lst/,$@); fi;
endef

#LINK/UNLINK FILES
define file-link
-if $(TEST) -L $(notdir $@); then $(UNLINK) $(notdir $@); fi;\
   if $(TEST) ! -L $(notdir $@); then $(SYMLINK) $@ ./; fi
endef

define file-unlink
-if $(TEST) -L $(notdir $@); then unlink $(notdir $@); fi;
endef

define convert_img_to_eps
$(CONVERT) $< eps:$@
endef

#include local re/definition
ifdef MK_DIR
-include $(MK_DIR)/paths.local.mk
else
-include ../Mk/paths.local.mk
-include ../../Mk/paths.local.mk
endif
