include <washer_spacer.scad>;

difference(){
  union(){
    cylinder(r=spacer_diameter/2, h=spacer_thickness);
    translate([0, 0, spacer_thickness]){

      cylinder(r=washer_diameter/2, h=washer_thickness);
    }
  }
  cylinder(r=spacer_inner_diameter/2, h=washer_thickness+spacer_thickness);
}
