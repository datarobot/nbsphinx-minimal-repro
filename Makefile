# Makefile for Sphinx documentation
#

# You can set these variables from the command line.
SPHINXOPTS    = -n
SPHINXBUILD   = sphinx-build
PAPER         =
BUILDDIR      = _build

# Internal variables.
PAPEROPT_a4     = -D latex_paper_size=a4
PAPEROPT_letter = -D latex_paper_size=letter
ALLSPHINXOPTS   = -d $(BUILDDIR)/doctrees $(PAPEROPT_$(PAPER)) $(SPHINXOPTS) .
# the i18n builder cannot share the environment and doctrees with the others
I18NSPHINXOPTS  = $(PAPEROPT_$(PAPER)) $(SPHINXOPTS) .

VERSION = $(shell python version.py)

.PHONY: help clean html xelatexpdf text

help:
	@echo "Please use \`make <target>' where <target> is one of"
	@echo "  html       to make standalone HTML files"
	@echo "  xelatexpdf to make xeLaTeX files and run them through pdflatex"

clean:
	-rm -rf $(BUILDDIR)/*
	-rm -f datarobot_examples.zip

html:
	$(SPHINXBUILD) -W -b html $(ALLSPHINXOPTS) $(BUILDDIR)/html
	@echo
	@echo "Build finished. The HTML pages are in $(BUILDDIR)/html."

xelatexpdf:
	$(SPHINXBUILD) -W -b latex $(ALLSPHINXOPTS) $(BUILDDIR)/latex
	@echo "Running LaTeX files through xelatex..."
	$(MAKE) PDFLATEX=xelatex -C $(BUILDDIR)/latex all-pdf
	@echo "Making index..."
	makeindex $(BUILDDIR)/latex/*.idx
	@echo "Re-running LaTeX files through xelatex to build index..."
	$(MAKE) PDFLATEX=xelatex -C $(BUILDDIR)/latex all-pdf
	@echo "xelatex finished; the PDF files are in $(BUILDDIR)/latex."
