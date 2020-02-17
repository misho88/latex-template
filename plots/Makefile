SVG_TO_PDF=rsvg-convert -f pdf

PDF_PLOTS=pdf_plot_1.pdf pdf_plot_2.pdf
SVG_PLOTS=svg_plot_1.svg svg_plot_2.svg

SVG_PLOTS_AS_PDF=$(SVG_PLOTS:.svg=.pdf)
ALL_PLOTS=$(PDF_PLOTS) $(SVG_PLOTS_AS_PDF)

all: $(ALL_PLOTS)

$(PDF_PLOTS) &: make_pdf_plots.py
	./make_pdf_plots.py

$(SVG_PLOTS) &: make_pdf_plots.py
	./make_svg_plots.py

%.pdf: %.svg
	$(SVG_TO_PDF) < $< > $@

clean: clean_svg clean_pdf

clean_svg:
	rm -f *.svg

clean_pdf:
	rm -f *.pdf
