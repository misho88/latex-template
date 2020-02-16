LATEXMK=latexmk
PDFVIEW=show-pdf  # xdg-open??
PDFLATEX=pdflatex -interaction=nonstopmode

SOURCE?=master.tex  # should be set in env.sh
OUTPUT=$(SOURCE:.tex=.pdf)

all: $(OUTPUT)

%.tex: %.raw
	./raw2tex $< > $@

%.tex: %.dat
	./dat2tex $< > $@

$(OUTPUT): $(SOURCE)
	$(LATEXMK) -pdf -pdflatex="${PDFLATEX}" -use-make $<

clean:
	$(LATEXMK) -CA -use-make

show: $(OUTPUT)
	$(PDFVIEW) $<

