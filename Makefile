%.stl: %.scad
	openscad -o $@ $<