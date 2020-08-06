all : thesis.pdf list-of-publications.pdf cover-page.pdf

%.pdf : %.tex defs.tex %.bbl
	latexmk -pdf -shell-escape $<

thesis.pdf : defs.tex abstract.tex acknowledgements.tex intro.tex preliminaries.tex \
			 stateoftheart.tex realprogs.tex memorymodels.tex termination.tex \
			 conclusion.tex papers.tex

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

clean:
	rm -f *.aux *.bbl *.bcf *.blg *.fdb_latexmk *.fls *.log *.out *.run.xml *.toc *.pyg

.PRECIOUS: %.bcf %.bbl

.PHONY: all clean
