ALL=$(wildcard *.md) publications.tex
PAPERS=# pdfs

all : thesis.pdf list-of-publications.pdf

%.pdf : %.tex %.bbl
	latexmk -pdf -shell-escape $<

thesis.pdf : $(wildcard *.tex)

list-of-publications.pdf : papers.tex

# thesis-print.pdf : thesis-print.tex $(ALL:.md=.tex) thesis-print.bbl $(PAPERS)
#	./latexwrap $<

# thesis-print.tex : thesis.tex
#	sed -e 's/linkcolor={.*}/linkcolor={black}/' \
#		-e 's/citecolor={.*}/citecolor={black}/' \
#		-e 's/urlcolor={.*}/urlcolor={black}/' \
#		-e 's/\\iffalse.*%@ifprint/\\iftrue/' \
#		$< > $@

%.bbl : %.bcf
	biber $(@:.bbl=)

%.bcf : $(wildcard *.bib) $(wildcard *.tex)
	pdflatex -shell-escape $(@:%.bcf=%.tex)

.PRECIOUS: %.bcf %.bbl

.PHONY: all
