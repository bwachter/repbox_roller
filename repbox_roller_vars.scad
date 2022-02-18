use <MCAD/2Dshapes.scad>;

$fn=40;

base_thickness = 3.8;
main_length = 175.5;
main_height = 37;
cutout_length = 74;

// to allow multiple bearings in one assembly later calculations typically
// should not use those, but calculate based on total thickness
bearing_spacer_thickness = 0.6;
bearing_shaft_height = 3.6;

bearing_offset_x = 44;
bearing_offset_y = 14;
// this is the actual diameter + some buffer space around it
bearing_diameter = 25;

bearing_spacer_diameter = 11.5;
bearing_shaft_diameter = 7.6;

// diameter to cutout for the rod this will sit on
rod_diameter = 21;
// offset from the edge of this assembly to the edge of the roller bar
rod_x_offset = 12.2;
rod_y_offset = 11.5;

rod_center_y = rod_y_offset + rod_diameter/2;
rod_center_x = main_length/2 - rod_x_offset - rod_diameter/2;

bearing_center_x = main_length/2-bearing_offset_x;
bearing_center_y = bearing_offset_y;

bearing_center_v = [bearing_center_x, bearing_offset_y, 0];
rod_center_v = [rod_center_x, rod_center_y, 0];

screw_head_diameter = 6;
screw_head_height = 3;
screw_diameter = 2.9;
