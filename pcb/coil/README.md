Coil blade
===========

The relevant shapes are generated programmatically which are then
put together manually in a kicad_pcb with some local changes.

 * coil-gen.cc  generates the coil windings
 * coil-edge-cuts.ps  Shape of the coil-blade, written in PostScript.
   Used to generate DXF, which then is imported to KiCAD.
