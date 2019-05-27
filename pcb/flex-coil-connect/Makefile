# -*- Makefile -*-

FABZIP=flatflex-fab.zip

all : $(FABZIP)

edge-cuts.dxf:

%.zip : %.kicad_pcb
	python ../kicad-scripts/kicad-fab.py $*
	zip -r $@ $*

%-fab.kicad_pcb : %.kicad_pcb
	sed "s/%%gitversion%%/`git log --date=short --pretty=format:'%h@%cd' -n 1 $<`/" < $^ > $@

%.dxf: %.ps
	pstoedit -psarg "-r600x600" -nb -mergetext -dt -f "dxf_s:-mm -ctl -splineaspolyline -splineprecision 30" $< $@

clean:
	rm -rf $(FABZIP) $(FABZIP:.zip=)
