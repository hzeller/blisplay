$fn=120;
e=0.01;

acrylic_t = 3;   // Acrylic thickness for laser-cut parts

// The "display" dots.
dots_x=4;
dots_y=6;
dot_dist=2;
dot_dia=1;

// The magnets.
mag_len=1.5*25.4;   // Length of the whole magnet
mag_w=25.4/4;       // width of the poles we look at.
mag_thick=25.4/4;   // Poles are on opposite ends of the thickness

// Driver PCB.
driver_board_width=38;
driver_board_height=9;
driver_board_thick=0.8;
driver_flex_distance=21;

space_between_magnets=driver_board_height;
coil_height=2*mag_w + space_between_magnets;
coil_thick=0.4;

yoke_wall=25.4/8;      // thickness of yoke material.
yoke_transparency = 0.5;

center_w=dots_x * dot_dist;

yoke_width = center_w + 2*mag_thick+2*yoke_wall;

poke_len=2;
poke_off_angle=-3;
poke_on_angle=0;

flex_width=2;
stack_layer_count = (dots_y * dots_x) / 2;  // half on each side

// To be shared with the postscript.
fulcrum_dia=2;
fulcrum_ring=1;
fulcrum_distance=28;

optical_clearance = 30;   // Clearance at the bottom for the optical system

echo("Coil PCB size: ", coil_height + poke_len, "x",
     fulcrum_distance+fulcrum_dia+fulcrum_ring);

module finger_cradle(elevate=2.5, finger_diameter=20, finger_hug_height=6) {
     fh=finger_hug_height;
     fr=finger_diameter / 2;
     actuator_space=1.2;   // Space above actuators, e.g. for dampening felt.
     translate([0,0,elevate]) difference() {
	  hull() {  // Outer space.
	       intersection() {
		    translate([0, 0, fr-0.5]) scale([1, 1.6, 1]) sphere(r=fr+0.5);
		    translate([0,0,fh/2]) cube([20, 32, fh], center=true);
	       }
	       translate([0,-8,fh/2]) cube([20, 16, fh], center=true);
	       translate([0,0,-elevate+0.5]) cube([yoke_width, 32, 1], center=true);
	  }
	  hull() {  // Space to keep felt dampener
	       translate([0, 0, -elevate+actuator_space]) cube([4*2+2, 35+2*e, e], center=true);
	       translate([0, 0, -elevate-e]) cube([4*2+6, 35+2*e, e], center=true);
	  }
	  // Punch the space for the actuator pins to come through.
	  punch_height=fh+elevate;
	  punch_corner_r=2;
	  punch_w = (dots_x*dot_dist+1)/2 - punch_corner_r;
	  punch_h = (dots_y*dot_dist+1)/2 - punch_corner_r;
	  // Make a rounded corner hole.
	  translate([0, 0, -punch_height/2]) hull() {
	       translate([punch_w, punch_h, 0]) cylinder(r=punch_corner_r, h=punch_height);
	       translate([-punch_w, punch_h, 0]) cylinder(r=punch_corner_r, h=punch_height);
	       translate([-punch_w, -punch_h, 0]) cylinder(r=punch_corner_r, h=punch_height);
	       translate([punch_w, -punch_h, 0]) cylinder(r=punch_corner_r, h=punch_height);
	  }
	  translate([0, 0, fr-0.5]) scale([1, 1.2, 1]) sphere(r=fr);
	  //translate([0, 0, fr+0.5]) rotate([90, 0, 0]) cylinder(r=fr, h=20);
     }
}

module magnet() {
     color("red") translate([-mag_thick/2,-mag_len/2,0]) cube([mag_thick/2, mag_len, mag_w]);
     color("green") translate([0,-mag_len/2,0]) cube([mag_thick/2, mag_len, mag_w]);
}


module yoke(with_magnet=false) {
     translate([-mag_thick, 0, -coil_height/2]) {
	  color([0.5, 0.5, 0.5, yoke_transparency])
	       translate([-yoke_wall, -mag_len/2, 0])
	       cube([yoke_wall, mag_len, coil_height]);
	  if (with_magnet) {
	       translate([mag_thick/2, 0, 0]) magnet();
	       translate([mag_thick/2, 0, coil_height]) rotate([0,180,0]) magnet();
	  }
     }
     translate([-mag_thick, 0, 0]) driver_board();
}

module coil(poke_pos=0, is_poke) {
     //echo(poke_pos, " -> ", is_poke);
     poke_width=0.8;
     translate([0, fulcrum_distance-0.5, coil_height/2])
     rotate([is_poke ? -poke_on_angle : -poke_off_angle, 0, 0]) translate([0, -fulcrum_distance+0.5, -coil_height/2])
	  color("#00ef00") render() difference() {
	       translate([0, (dot_dist-poke_width)/2, 0]) rotate([90, 0, 90])
	       linear_extrude(height=coil_thick, center=true, convexity = 10)
	       import (file = "pcb/coil/coil-edge-cuts.dxf");
	  // Remove the fingers that we're not interested in.
	  for (i = [0:3]) {
	       if (i != poke_pos) {
		    translate([-1, (dot_dist-poke_width)/2 + i*dot_dist-0.5, coil_height])
			 cube([2, dot_dist+0.5, 5]);
	       }
	  }
     }
}

module coil_triplet(x_pos, poke_array) {
     translate([-dot_dist/3, 0, 0])
	  coil(0, is_poke=poke_array[2*dots_x + x_pos]);
     angle = 0;
     translate([0, fulcrum_distance, coil_height/2]) rotate([angle,0,0])
	  translate([0, -fulcrum_distance, -coil_height/2])
	  coil(1, is_poke=poke_array[1*dots_x + x_pos]);
     translate([dot_dist/3, 0, 0])
	  coil(2, is_poke=poke_array[0*dots_x + x_pos]);
}

module coil_stack(poke_array) {
     //echo("poke", poke_array);
     offset = (dots_x-1) * dot_dist / 2.0;
     for (i = [0:1:dots_x-e]) {
	  translate([i * dot_dist - offset, 0, 0])
	       coil_triplet(i, poke_array);
     }
}

module actuators(poke_array) {
     rotate([0,0,180]) coil_stack(poke_array=poke_array);

     // The back is rotated and turned, so easy if we just map flipped array
     reflect_array = [for (i = [0:24]) poke_array[23-i]];
     coil_stack(poke_array=reflect_array);
}

module magnet_assembly() {
     translate([-center_w/2, 0, coil_height/2]) yoke(with_magnet=true);
     translate([center_w/2, 0, coil_height/2]) rotate([180,0,180]) yoke(with_magnet=true);
}

module fulcrum_axles() {
     // Fulcrum axles.
     fulcrum_len=dots_x * dot_dist + 2*mag_thick;
     color("silver") translate([0, fulcrum_distance, coil_height/2])
	  rotate([0,90,0]) translate([0,0,-fulcrum_len/2]) cylinder(r=fulcrum_dia/2, h=fulcrum_len);
     color("silver") translate([0, -fulcrum_distance, coil_height/2])
	  rotate([0,90,0]) translate([0,0,-fulcrum_len/2]) cylinder(r=fulcrum_dia/2, h=fulcrum_len);
}

module driver_board(realistic=true) {
     color("lightgreen") {
	  rotate([0, 90, 0]) rotate([0, 0, 90]) translate([-119, 54.5, 0]) import(file = "pcb/driver-oc/blisplay-driver-oc.stl");
     }
}

module yoke_spacer_screw() {
     round_edge_radius=fulcrum_dia/2 + 2;
     color("#FFBB00") translate([center_w/2, 0, 0]) {
	  // Distance holders
	  translate([-center_w, -fulcrum_distance, coil_height/2-round_edge_radius]) rotate([0, 90, 0]) difference() {
	       cylinder(r=round_edge_radius, h=center_w);
	       translate([0, 0, -e]) cylinder(r=3.2/2, h=center_w+2*e);
	  }
	  translate([-center_w, fulcrum_distance, -coil_height/2+round_edge_radius]) rotate([0, 90, 0]) difference() {
	       cylinder(r=round_edge_radius, h=center_w);
	       translate([0, 0, -e]) cylinder(r=3.2/2, h=center_w+2*e);
	  }
     }
}

// TODO: this is a lot of empty space in the yoke-spacer, that we can fill
// with electronics later.
module yoke_spacer() {
     round_edge_radius=fulcrum_dia/2 + 2;
     yoke_outer_wall = (yoke_width - center_w)/2;
     color("#FFBB00") translate([center_w/2,0,0]) {
	  difference() {
	       union() {
		    // center piece, probably later more hollow for electronics
		    translate([mag_thick/2,0,0]) cube([mag_thick, mag_len, space_between_magnets], center=true);

		    hull() {
			 translate([0, mag_len/2, -coil_height/2]) cube([mag_thick+yoke_wall, e, coil_height]);
			 translate([0, fulcrum_distance, coil_height/2-round_edge_radius]) rotate([0, 90, 0]) cylinder(r=round_edge_radius, h=mag_thick+yoke_wall);
			 translate([0, fulcrum_distance, -coil_height/2+round_edge_radius]) rotate([0, 90, 0]) cylinder(r=round_edge_radius, h=mag_thick+yoke_wall);
		    }

		    hull() {
			 translate([0, -mag_len/2, -coil_height/2]) cube([mag_thick+yoke_wall, e, coil_height]);
			 translate([0, -fulcrum_distance, coil_height/2-round_edge_radius]) rotate([0, 90, 0]) cylinder(r=round_edge_radius, h=mag_thick+yoke_wall);
			 translate([0, -fulcrum_distance, -coil_height/2+round_edge_radius]) rotate([0, 90, 0]) cylinder(r=round_edge_radius, h=mag_thick+yoke_wall);
		    }
	       }

	       // Holes for the fulcrum. Not entirely punched through to the end
	       translate([-e, fulcrum_distance, 0]) rotate([0,90,0]) cylinder(r=fulcrum_dia/2+0.2, h=yoke_outer_wall-1);
	       translate([-e, -fulcrum_distance, 0]) rotate([0,90,0]) cylinder(r=fulcrum_dia/2+0.2, h=yoke_outer_wall-1);

	       // Screw for the distance holders
	       translate([mag_thick+yoke_wall, -fulcrum_distance, coil_height/2-round_edge_radius]) rotate([0, -90, 0]) mount_screw(h=yoke_width);

	       // Crude cut-out to have a smooth screw holder
	       translate([mag_thick+yoke_wall-2+e, -fulcrum_distance-3, coil_height/2-round_edge_radius]) cube([4, 6, 6], center=true);
	       translate([mag_thick+yoke_wall-2+e, -fulcrum_distance, coil_height/2-round_edge_radius+3]) cube([4, 6, 6], center=true);

	       translate([mag_thick+yoke_wall-2+e, +fulcrum_distance+3, -coil_height/2+round_edge_radius]) cube([4, 6, 6], center=true);
	       translate([mag_thick+yoke_wall-2+e, fulcrum_distance, -coil_height/2+round_edge_radius-3]) cube([4, 6, 6], center=true);

	       translate([mag_thick+yoke_wall, +fulcrum_distance, -coil_height/2+round_edge_radius]) rotate([0, -90, 0]) mount_screw(h=yoke_width);

	       // ... the bolts from the other end
	       translate([-center_w-mag_thick-yoke_wall, -fulcrum_distance, -coil_height/2+round_edge_radius]) rotate([0, 90, 0]) mount_screw(h=yoke_width);
	       translate([-center_w-mag_thick-yoke_wall, +fulcrum_distance, coil_height/2-round_edge_radius]) rotate([0, 90, 0]) mount_screw(h=yoke_width);
	  }
     }
}

module print_yoke_spacers() {
     rotate([0, -90, 0]) yoke_spacer();
     translate([15, 15, 0]) rotate([0, -90, 0]) yoke_spacer();

     translate([-20, 0, center_w]) rotate([0, 90, 0]) {
	  yoke_spacer_screw();
     }
     translate([-20, 0, center_w]) rotate([0, -90, 0]) {
	  yoke_spacer_screw();
     }
}

// Tool to hold up spacer while assembling
module assembly_tool_spacer_holder() {
     bottom_thick=1;
     yoke_outer_wall = (yoke_width - center_w)/2;
     difference() {
	  hull() {
	       translate([0,10,0]) cylinder(r=15, h=bottom_thick);
	       translate([0,-10,0]) cylinder(r=15, h=bottom_thick);
	       translate([0,0,yoke_outer_wall]) cube([space_between_magnets+2, mag_len-mag_w, 1], center=true);
	  }
	  translate([0,0,10+bottom_thick]) cube([space_between_magnets+0.2, 60, 20], center=true);
     }
}

module flex_loop(len=10, width=flex_width-0.1, thickness=0.15, tongue=3) {
     radius = (len + thickness)/2;
     tongue_stick=0.0;
     translate([0, width/2, 0]) rotate([90, 0, 0]) {
	  linear_extrude(height=tongue) translate([len-thickness/2, -tongue_stick, 0]) square([thickness, 3]);
	  linear_extrude(height=width) translate([len/2, 0])
	       union() {
	         translate([-len/2-thickness/2, 0, 0]) square([thickness, 3]);
	         translate([len/2-thickness/2, 0, 0]) square([thickness, 3]);
		 translate([0, 0, 0]) difference() {  // The loop
		      circle(r=radius);
		      circle(r=radius - thickness);
		      translate([-radius, 0, 0]) square([2*radius+e, 2*radius]);
		 }
	  }
     }
}

module flex_connector(center_space=2) {
     color("#ffbf00") translate([-center_w/2 - mag_thick, 0, 0]) {
	  // We connect two coils with the right and left flex-loop.
	  lips = stack_layer_count/4;
	  for (i = [0:lips-e]) {
	       translate([0, -(lips-i)*flex_width+center_space/2, 0]) flex_loop(len=mag_thick + (2*i+1) * dot_dist/3);
	       // Mirror
	       scale([1, -1, 1]) translate([0, -(lips-i)*flex_width+center_space/2, 0]) flex_loop(len=mag_thick + (2*i+1) * dot_dist/3);
	  }
     }
}

module flex_wiring() {
     translate([0, driver_flex_distance/2, 0]) flex_connector();
     translate([0, -driver_flex_distance/2, 0]) flex_connector();
     rotate([0, 0, 180]) {
	  translate([0, driver_flex_distance/2, 0]) flex_connector();
	  translate([0, -driver_flex_distance/2, 0]) flex_connector();
     }
}

// This is how it all looks.
module assembly(poke_array=[]) {
     actuators(poke_array);
     translate([0,0,coil_height/2]) {
	  { yoke_spacer(); yoke_spacer_screw(); }
	  rotate([0,0,180]) { yoke_spacer(); yoke_spacer_screw(); }
     }
     magnet_assembly();
     fulcrum_axles();
     translate([0, 0, coil_height]) color("red") render() finger_cradle();
     flex_wiring();
}

module mount_screw(h=17) {
     translate([0,0,-e]) cylinder(r=6/2, h=4);
     cylinder(r=3.2/2, h=h);
     translate([0, 0, h-3]) cylinder(r=7/2, h=20, $fn=6);
}

// Pixels that are currently up.
poke_array = [for (i = [0:23]) true];

d = 4;
if (d == 0) {
     coil_stack();
} else if (d == 1) {
     yoke(with_magnet=true);
} else if (d == 2) {
     coil_stack(poke_array);
     magnet_assembly();
     flex_wiring();
} else if (d == 3) {
     translate([0,0,coil_height/2]) {
	  yoke_spacer(); /*yoke_spacer_screw(); */}
} else {
     assembly(poke_array);
}
