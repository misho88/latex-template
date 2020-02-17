PDFVIEW=bin/show-pdf
PDFLATEX=pdflatex -interaction=nonstopmode

LATEXMK=latexmk -use-make
LATEXMK_FLAGS=-pdf -pdflatex="${PDFLATEX}" -f

SOURCE?=master.tex
OUTPUT=document.pdf

SUBDIRS=$(shell find . -mindepth 1 -maxdepth 1 -type d -not -name .\*)
SRC_SUBDIRS=$(shell for dir in $(SUBDIRS); do \
	if [[ -f "$${dir}/Makefile" ]]; then \
		echo "$${dir}"; \
	fi; \
done)

all: $(OUTPUT)

debug:
	echo $(SRC_SUBDIRS)

# latexmk triggers this rule if the plot is in the TeX source because of the
# -use-make flag
# This way, we can deal with all plotting rules in plots/Makefile
plots/%.pdf:
	$(MAKE) -C plots $(patsubst plots/%,%,$@)

# support other input formats
%.tex: %.raw
	./raw2tex $< > $@

%.tex: %.dat
	./dat2tex $< > $@

# if the output name isn't the same as the master doc's, copy
$(OUTPUT): $(SOURCE:.tex=.pdf)
	[[ "$<" == "$@" ]] || cp "$<" "$@"

# build the master document
$(SOURCE:.tex=.pdf): $(SOURCE)
	$(LATEXMK) $(LATEXMK_FLAGS) "$(SOURCE)"
	$(LATEXMK) -c "$(SOURCE)"

clean-except-output:
	for dir in $(SRC_SUBDIRS); do $(MAKE) clean -C "$$dir"; done
	[[ "$(OUTPUT)" == "$(SOURCE:.tex=.pdf)" ]] && $(LATEXMK) -c "$(SOURCE)" || $(LATEXMK) -C "$(SOURCE)"
	rm -f $(SOURCE:.tex=.bbl)
	rm -f $(OUTPUT:.pdf=.tar.gz)
	rm -f $(OUTPUT:.pdf=.zip)

# clean up
clean: clean-except-output
	rm -f "$(OUTPUT)"

# show the document
show: $(OUTPUT)
	$(PDFVIEW) $<

# rebuild automatically
auto:
	bin/watch-for-edits --file "$(SOURCE)" --command $(MAKE)

# rebuild automatically quietly in the background
auto-quiet-bg:
	bin/watch-for-edits -qe --file "$(SOURCE)" --command $(MAKE) &

# make an archive with the document and its sources
package-tar-gz: $(OUTPUT) clean-except-output
	tar --exclude=".git*" -zcvf $(OUTPUT:.pdf=.tar.gz) .

# make an archive with the document and its sources
package-zip: $(OUTPUT) clean-except-output
	zip --exclude=".git*" -r $(OUTPUT:.pdf=.zip) .

# I'm not actually sure what this is good for
package-repo: $(OUTPUT) clean-except-output
	tar -zcvf $(OUTPUT:.pdf=.tar.gz) .
