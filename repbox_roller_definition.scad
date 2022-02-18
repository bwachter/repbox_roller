// in retrospect this whole thing would've been more sensible with a
// full 2d base and only minimal alterations to that later on - maybe
// fix that in the next generation.

main_thickness = base_thickness+cutout_thickness;

module copy_mirror(vec=[0,1,0])
{
    children();
    mirror(vec) children();
}

// this defines the parts which are same on both sides, and can just be mirrored later on
module half_roller(){
  difference(){
    // main body
    union(){
      difference(){
        cube([main_length/2, main_height, main_thickness]);
        // top corner
        translate([main_length/2-20, 0, 0]){
          cube([20, 20, main_thickness]);
        }
      }
      // replace top corner with round thing
      translate([main_length/2-20, 20, 0]){
        linear_extrude(main_thickness) pieSlice(size=20, start_angle=270, end_angle=360);
      }
    }
    // central cutout
    translate([0, 0, main_thickness - cutout_thickness]){
      cube([cutout_length/2, main_height, cutout_thickness]);
    }
    translate([cutout_length/2, 0, main_thickness - cutout_thickness]){
      cube([cutout_length/2, main_height - (main_height-bearing_diameter/2-bearing_offset_y) - 2, cutout_thickness]);
    }

    // cutouts on the sides
    translate([main_length/2-rod_x_offset, 0, main_thickness - cutout_thickness]){
      cylinder(h=cutout_thickness, r=20,$fn=3);
    }

    // bearing_diameter already contains some margins, so no additional margins should be required here
    translate(bearing_center_v){
      translate([0,0,base_thickness]){
        cylinder(h=cutout_thickness, r=bearing_diameter/2);
      }
    }

    translate(rod_center_v){
      rod_grip_size=1.5;
      cylinder(h=main_thickness, r=rod_diameter/2);
      translate([(rod_diameter/2*-1)+rod_grip_size,0,0]){
      cube([rod_diameter-rod_grip_size, rod_diameter/2+(main_height-rod_y_offset+rod_diameter), main_thickness]);
      }
    }

    // top cutout
    translate([0, (main_length/2*-1)+60, 0]){
      cylinder(h=main_thickness, r=main_length/2-40);
    }


  }

  translate(bearing_center_v){
    cylinder(h=main_thickness, r=bearing_shaft_diameter/2);
    translate([0,0,base_thickness]){
      cylinder(h=bearing_spacer_thickness, r=bearing_spacer_diameter/2);
    }
  }
}

bearing_interlock_offset = 2;
tolerance = 0.2;
side_interlock_offset = 2;
side_interlock_diameter = 4;

side_interlock_xy=[main_length/2-rod_x_offset/2, main_height-side_interlock_offset-side_interlock_diameter/2];
side_interlock_v=[main_length/2-side_interlock_offset, main_height-side_interlock_offset, main_thickness];

difference(){
  union() {
    copy_mirror([1, 0, 0]){half_roller();}
    // interlock on the bearing
    translate([bearing_center_x, bearing_offset_y, main_thickness]){
      cylinder(h=bearing_interlock_offset, r=bearing_shaft_diameter/2-1);
    }
    // interlock on the side
    translate([side_interlock_xy[0], side_interlock_xy[1], main_thickness]){
      cylinder(h=side_interlock_offset, r=side_interlock_diameter/2);
      translate([0, -20, 0]){
        cylinder(h=side_interlock_offset, r=side_interlock_diameter/2);
      }
    }
    // interlock on the bottom, under the bearing
    translate([bearing_center_x, side_interlock_xy[1], main_thickness]){
      cylinder(h=side_interlock_offset, r=side_interlock_diameter/2);
    }
  }
  // screw head hole
  translate([bearing_center_x, bearing_center_y, 0]){
    cylinder(h=screw_head_height, r=screw_head_diameter/2);
    cylinder(h=main_thickness+bearing_interlock_offset, r=screw_diameter/2);
  }
  // screw hole other side
  translate([bearing_center_x*-1, bearing_offset_y, 0]){
    cylinder(h=main_thickness, r=screw_diameter/2);
  }
  // interlock cutout on the bearing
  translate([bearing_center_x*-1, bearing_offset_y, main_thickness-bearing_interlock_offset-tolerance]){
    cylinder(h=bearing_interlock_offset+tolerance, r=bearing_shaft_diameter/2-1);
  }
  // interlock cutouts on the sides
  translate([side_interlock_xy[0]*-1, side_interlock_xy[1], main_thickness-side_interlock_offset-tolerance]){
    cylinder(h=side_interlock_offset+tolerance, r=side_interlock_diameter/2);
    translate([0, -20, 0]){
      cylinder(h=side_interlock_offset+tolerance, r=side_interlock_diameter/2);
    }
  }

  // interlock cutout on the bottom, under the bearing
    translate([bearing_center_x*-1, side_interlock_xy[1], main_thickness-side_interlock_offset-tolerance]){
      cylinder(h=side_interlock_offset+tolerance, r=side_interlock_diameter/2);
    }

}
