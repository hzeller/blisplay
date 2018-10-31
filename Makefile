ALL_TARGETS= fab/lasercut_sidewall.dxf \
             fab/print_yoke_spacers.stl \
             fab/print_yokes_magnetic_filament.stl \
             fab/assembly_tool_spacer_holder.stl

all : $(ALL_TARGETS)

%.dxf: %.ps
	pstoedit -psarg "-r600x600" -nb -mergetext -dt -f "dxf_s:-mm -ctl -splineaspolyline -splineprecision 30" $< $@

%.png : %.ps
	../scripts/ps2pnm 240 $< | pnmscale 0.25 | pnmtopng > $@

fab/%.scad : blisplay.scad coil-shape.dxf
	mkdir -p fab/
	echo 'use <blisplay.scad>\n$*();' > $@

%.dxf %.stl: %.scad
	openscad -o $@ $<

clean:
	rm -f $(ALL_TARGETS)
