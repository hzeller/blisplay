CXXFLAGS=-std=c++11 -Wall -Wextra

../blisplay.pretty/coil.kicad_mod: coil-gen
	./coil-gen > $@

coil-edge-cuts.dxf:

coil-gen: coil-gen.cc

%.dxf: %.ps
	pstoedit -psarg "-r600x600" -nb -mergetext -dt -f "dxf_s:-mm -ctl -splineaspolyline -splineprecision 30" $< $@

clean:
	rm -rf coil-gen coil-pcb-fab.zip plot/
