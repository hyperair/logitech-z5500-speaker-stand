INKSCAPEDIR = /usr/share/inkscape/extensions/
DXF_OUTLINES = $(INKSCAPEDIR)/dxf_outlines.py
OPENSCAD = openscad

SCADFILES = whole-mount.scad
STLFILES = $(SCADFILES:.scad=.stl)
DEPFILES = $(addsuffix deps,$(SCADFILES))

all: $(STLFILES)

%.dxf: %.svg
	$(DXF_OUTLINES) --units='25.4/90' --encoding=latin1 $< > $@

%.stl: %.scad
	$(OPENSCAD) -d $<deps -m $(MAKE) -o $@ $<

clean:
	rm $(STLFILES) $(DEPFILES)

-include $(DEPFILES)
