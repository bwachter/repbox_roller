include <washer_spacer.scad>;

difference(){
  cylinder(r=washer_diameter/2, h=washer_thickness);
  cylinder(r=washer_inner_diameter/2, h=washer_thickness);
}
translate([0, 0, washer_thickness]){
  difference(){
    cylinder(r=spacer_inner_diameter/2, h=washer_thickness+spacer_thickness);
    cylinder(r=washer_inner_diameter/2, h=washer_thickness+spacer_thickness);
  }
}
