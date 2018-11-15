all : outline.dxf

%.dxf: %.ps
	pstoedit -psarg "-r600x600" -nb -mergetext -dt -f "dxf_s:-mm -ctl -splineaspolyline -splineprecision 30" $< $@

clean:
	rm -f outline.dxf
