CXXFLAGS=-std=c++11 -Wall -Wextra
FABZIP=coil-pcb-fab.zip

all: $(FABZIP)

../blisplay.pretty/coil.kicad_mod: coil-gen
	./coil-gen > $@

coil-edge-cuts.dxf:

coil-gen: coil-gen.cc

%.zip : %.kicad_pcb
	python ../kicad-scripts/kicad-fab.py $*
	zip -r $@ $*

%.dxf: %.ps
	pstoedit -psarg "-r600x600" -nb -mergetext -dt -f "dxf_s:-mm -ctl -splineaspolyline -splineprecision 30" $< $@

%-fab.kicad_pcb : %.kicad_pcb
	sed "s/%%gitversion%%/`git log --date=short --pretty=format:'%h@%cd' -n 1 $<`/" < $^ > $@

clean:
	rm -rf coil-gen $(FABZIP) $(FABZIP:.zip=)
