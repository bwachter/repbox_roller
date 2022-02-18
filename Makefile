Q?=@

all: repbox_roller.stl repbox_roller_double.stl spacer.stl washer.stl

%.stl: %.scad
	$(Q) echo "EXPORT $@"
	$(Q) openscad -o $@ $<
