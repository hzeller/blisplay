# -*- Makefile -*-

FABZIP=blisplay-driver-fab.zip

all : $(FABZIP)

%.zip : %.kicad_pcb
	python ../kicad-scripts/kicad-fab.py $*
	zip -r $@ $*

%-fab.kicad_pcb : %.kicad_pcb
	sed "s/%%gitversion%%/`git log --date=short --pretty=format:'%h@%cd' -n 1 $<`/" < $^ > $@

clean:
	rm -rf $(FABZIP) $(FABZIP:.zip=)
