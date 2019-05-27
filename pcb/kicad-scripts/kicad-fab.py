'''
  H. Zeller <h.zeller@acm.org>
  Based on gen_gerber_and_drill_files_board.py in kicad/demos directory.
'''

import sys
import os

from pcbnew import *
basename=sys.argv[1]

board = LoadBoard(basename + ".kicad_pcb")

plotDir = basename + "/"

pctl = PLOT_CONTROLLER(board)

popt = pctl.GetPlotOptions()

popt.SetOutputDirectory(plotDir)

# Set some important plot options:
popt.SetPlotFrameRef(False)
popt.SetLineWidth(FromMM(0.35))

popt.SetAutoScale(False)
popt.SetScale(1)
popt.SetMirror(False)
popt.SetUseGerberAttributes(True)
popt.SetUseGerberProtelExtensions(True)
popt.SetExcludeEdgeLayer(True);
popt.SetScale(1)
popt.SetUseAuxOrigin(True)

# This by gerbers only (also the name is truly horrid!)
popt.SetSubtractMaskFromSilk(False)

# param 0 is the layer ID
# param 1 is a string added to the file base name to identify the drawing
# param 2 is a comment
# Create filenames in a way that if they are sorted alphabetically, they
# are shown in exactly the layering the board would look like. So
#   gerbv *
# just makes sense. The drill-file will be numbered 00 so that it is first.
plot_plan = [
    ( Edge_Cuts, "1-Edge_Cuts",   "Edges" ),

    ( F_SilkS,   "2-SilkTop",     "Silk top" ),
    ( F_Paste,   "3-PasteTop",    "Paste top" ),
    ( F_Mask,    "4-MaskTop",     "Mask top" ),
    ( F_Cu,      "5-CuTop",       "Top layer" ),

    # We show the mask stacked first for easier visual inspection with copper
    ( B_Mask,    "6-MaskBottom",  "Mask bottom" ),
    ( B_Cu,      "7-CuBottom",    "Bottom layer" ),
    ( B_Paste,   "8-PasteBottom", "Paste Bottom" ),
    ( B_SilkS,   "9-SilkBottom",  "Silk Bottom" ),
]


for layer_info in plot_plan:
    pctl.SetLayer(layer_info[0])
    pctl.OpenPlotfile(layer_info[1], PLOT_FORMAT_GERBER, layer_info[2])
    # In case boardhouses can't deal with detailed names: this removes them.
    #pctl.OpenPlotfile("", PLOT_FORMAT_GERBER, layer_info[2])
    pctl.PlotLayer()

# At the end you have to close the last plot, otherwise you don't know when
# the object will be recycled!
pctl.ClosePlot()

# Fabricators need drill files.
# sometimes a drill map file is asked (for verification purpose)
drlwriter = EXCELLON_WRITER( board )
drlwriter.SetMapFileFormat( PLOT_FORMAT_PDF )

mirror = False
minimalHeader = False
offset = wxPoint(0,0)
mergeNPTH = True   # non-plated through-hole
drlwriter.SetOptions( mirror, minimalHeader, offset, mergeNPTH )

metricFmt = True
drlwriter.SetFormat( metricFmt )

genDrl = True
genMap = False
drlwriter.CreateDrillandMapFilesSet( plotDir, genDrl, genMap );

# We can't give just the filename for the name of the drill file at generation
# time, but we do want its name to be a bit different to show up on top.
# So this is an ugly hack to rename the drl-file to have a 0 in the beginning.
os.rename(plotDir + basename + ".drl", plotDir + basename + "-0.drl")
