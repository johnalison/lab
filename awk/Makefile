TEXFILENAME=testTexSlides


jetclustering_slides:
	awk -f makeslides.awk nominal.config plots_jet_declustering.config > $(TEXFILENAME).tex
	pdflatex $(TEXFILENAME).tex
	pdflatex $(TEXFILENAME).tex
	pdflatex $(TEXFILENAME).tex
	rm $(TEXFILENAME).snm
	rm $(TEXFILENAME).aux
	rm $(TEXFILENAME).out
	rm $(TEXFILENAME).nav
	rm $(TEXFILENAME).toc
	rm $(TEXFILENAME).log
