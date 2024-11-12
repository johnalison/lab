#
# make TEXFILENAME=SyntheticDatasets-00-07-01-selJetFix
#

TEXFILENAME=testTexSlides
NEW_DIR=analysis\/plots_synthetic_datasets_all_00-08-01

testSed:
	sed -i '' "s/PLOTDIR/$(NEW_DIR)/g" nominal_RunII_test.config
	echo "Replaced PLOTDIR with $(NEW_DIR) in nominal_RunII.config"


jetclustering_slides_year:
	cp nominal_RunII.config nominal_$(YEAR)_fromMake.config
	sed -i '' "s/PLOTDIR/$(NEW_DIR)/g" nominal_$(YEAR)_fromMake.config
	sed -i '' "s/YEAR/$(YEAR)/g" nominal_$(YEAR)_fromMake.config
	awk -f makeslides.awk nominal_$(YEAR)_fromMake.config plots_jet_declustering.config > $(TEXFILENAME)_$(YEAR).tex
	pdflatex $(TEXFILENAME)_$(YEAR).tex
	pdflatex $(TEXFILENAME)_$(YEAR).tex
	pdflatex $(TEXFILENAME)_$(YEAR).tex
	rm $(TEXFILENAME)_$(YEAR).snm
	rm $(TEXFILENAME)_$(YEAR).aux
	rm $(TEXFILENAME)_$(YEAR).out
	rm $(TEXFILENAME)_$(YEAR).nav
	rm $(TEXFILENAME)_$(YEAR).toc
	rm $(TEXFILENAME)_$(YEAR).log

jetclustering_slides:
	$(MAKE) jetclustering_slides_year YEAR=RunII
	$(MAKE) jetclustering_slides_year YEAR=UL18
	$(MAKE) jetclustering_slides_year YEAR=UL17
	$(MAKE) jetclustering_slides_year YEAR=UL16_preVFP
	$(MAKE) jetclustering_slides_year YEAR=UL16_postVFP
	$(MAKE) jetclustering_slides_year YEAR=Run3
	$(MAKE) jetclustering_slides_year YEAR=2022_preEE
	$(MAKE) jetclustering_slides_year YEAR=2022_EE
	$(MAKE) jetclustering_slides_year YEAR=2023_preBPix
	$(MAKE) jetclustering_slides_year YEAR=2023_BPix


jetclustering_slides_RunII:
	$(MAKE) jetclustering_slides_year YEAR=RunII

jetclustering_slides_UL18:
	$(MAKE) jetclustering_slides_year YEAR=UL18

jetclustering_slides_UL17:
	$(MAKE) jetclustering_slides_year YEAR=UL17

jetclustering_slides_UL16_preVFP:
	$(MAKE) jetclustering_slides_year YEAR=UL16_preVFP

jetclustering_slides_UL16_postVFP:
	$(MAKE) jetclustering_slides_year YEAR=UL16_postVFP

jetclustering_slides_Run3:
	$(MAKE) jetclustering_slides_year YEAR=Run3

jetclustering_slides_2022_preEE:
	$(MAKE) jetclustering_slides_year YEAR=2022_preEE

jetclustering_slides_2022_EE:
	$(MAKE) jetclustering_slides_year YEAR=2022_EE

jetclustering_slides_2023_preBPix:
	$(MAKE) jetclustering_slides_year YEAR=2023_preBPix

jetclustering_slides_2023_BPix:
	$(MAKE) jetclustering_slides_year YEAR=2023_BPix



check_reclustered_splitting_slides:
	awk -f makeslides_reclustering.awk nominal_check_reclustered_splittings.config plots_check_reclustered_splittings.config > $(TEXFILENAME).tex
	pdflatex $(TEXFILENAME).tex
	pdflatex $(TEXFILENAME).tex
	pdflatex $(TEXFILENAME).tex
	rm $(TEXFILENAME).snm
	rm $(TEXFILENAME).aux
	rm $(TEXFILENAME).out
	rm $(TEXFILENAME).nav
	rm $(TEXFILENAME).toc
	rm $(TEXFILENAME).log
