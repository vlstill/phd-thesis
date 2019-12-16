ALL=$(wildcard *.md) publications.tex
PAPERS=# pdfs

all : thesis.pdf

thesis.pdf : thesis.tex thesis.bbl $(wildcard *.tex)
	latexmk -pdf $<

# thesis-print.pdf : thesis-print.tex $(ALL:.md=.tex) thesis-print.bbl $(PAPERS)
#	./latexwrap $<

# thesis-print.tex : thesis.tex
#	sed -e 's/linkcolor={.*}/linkcolor={black}/' \
#		-e 's/citecolor={.*}/citecolor={black}/' \
#		-e 's/urlcolor={.*}/urlcolor={black}/' \
#		-e 's/\\iffalse.*%@ifprint/\\iftrue/' \
#		$< > $@

thesis.bbl : thesis.bcf
	biber $(@:.bbl=)

thesis.bcf : $(wildcard *.bib) $(wildcard *.tex)
	pdflatex thesis.tex

.PRECIOUS: %.bcf %.bbl

.PHONY: all
