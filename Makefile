THESIS_FILES = abstract.tex acknowledgements.tex intro.tex preliminaries.tex \
	  stateoftheart.tex realprogs.tex memorymodels.tex termination.tex \
	  conclusion.tex papers.tex

all : thesis.pdf thesis-print.pdf list-of-publications.pdf cover-page.pdf abstract.pdf abstract-cz.pdf

%.pdf : %.tex defs.tex %.bbl
	latexmk -pdf -shell-escape $<

%.pdf : %.md
	pandoc -V geometry:a4paper,margin=4.5cm -V pagestyle:empty $< -o $@

abstract.md : abstract.tex
	printf "# Analysis of Parallel C++ Programs\n\n## Vladimír Štill\n\n### Abstract\n\n" > $@
	sed 's/%.*//' $< >> $@

thesis.pdf : $(THESIS_FILES)
thesis-print.pdf : $(THESIS_FILES)

list-of-publications.pdf : papers.tex

thesis-print.tex : thesis.tex
	sed -e 's/linkcolor={.*}/linkcolor={black}/' \
		-e 's/citecolor={.*}/citecolor={black}/' \
		-e 's/urlcolor={.*}/urlcolor={black}/' \
		-e 's/\\iffalse.*%@ifprint/\\iftrue/' \
		$< > $@

%.bbl : %.bcf
	biber $(@:.bbl=)

%.bcf : $(wildcard *.bib) $(wildcard *.tex)
	pdflatex -shell-escape $(@:%.bcf=%.tex)

clean:
	rm -f *.aux *.bbl *.bcf *.blg *.fdb_latexmk *.fls *.log *.out *.run.xml *.toc *.pyg

.PRECIOUS: %.bcf %.bbl

.PHONY: all clean
