%.stl: %.scad
	openscad -o $@ $<
