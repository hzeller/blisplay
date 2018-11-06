
all : blisplay-logo-large.png blisplay-logo-small.png blisplay-logo-medium.png

%-large.png : %.ps
	gs -q -dNOPAUSE -dBATCH -sDEVICE=pngalpha -sOutputFile=$@ -r72x72 -g1000x340 $<

%-medium.png : %.ps
	gs -q -dNOPAUSE -dBATCH -sDEVICE=pngalpha -sOutputFile=$@ -r36x36 -g500x170 $<

%-small.png : %.ps
	gs -q -dNOPAUSE -dBATCH -sDEVICE=pngalpha -sOutputFile=$@ -r18x18 -g250x85 $<
