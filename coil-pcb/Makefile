CXXFLAGS=-std=c++11 -Wall -Wextra

blisplay.pretty/coil.kicad_mod: coil-gen
	./coil-gen > $@

coil-gen: coil-gen.cc

clean:
	rm -rf coil-gen coil-pcb-fab.zip plot/
