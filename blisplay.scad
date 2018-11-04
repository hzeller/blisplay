$fn=32;
e=0.01;

acrylic_t = 3;   // Acrylic thickness for laser-cut parts

// The "display" dots.
dots_x=4;
dots_y=6;
dot_dist=2;
dot_dia=1;

// The magnets.
mag_len=1.5*25.4;
mag_w=25.4/4;
mag_thick=25.4/4;

// Driver PCB.
driver_board_width=36;
driver_board_len=28;
driver_board_frame = 1;  // Frame around driver board to hold it.
driver_board_offset=15;  // first solder point that needs to be outside
driver_board_thick=1.6;

driver_board_space_needed = driver_board_width + 2 * driver_board_frame;

coil_height=3*mag_w;
coil_thick=0.4;
coil_short=0;  // leave space to move at end.. typically !needed b/c yoke_space

top_yoke=true;
yoke_wall=1.2*mag_w;   // Large enough to capture most field-lines.
yoke_space=4;          // Space around magnets.
yoke_transparency = 1;

center_w=dots_x * dot_dist;
yoke_width = max(center_w + 2*mag_thick+2*yoke_wall,
		 driver_board_space_needed);
yoke_len = mag_len + 2*yoke_wall + 2*yoke_space;

poke_len=2;
poke_angle=3;
fingerpad_thick=0.7;

fulcrum_dia=2;
fulcrum_ring=1;
fulcrum_distance=(mag_len + yoke_wall)/2 + yoke_space;

mount_holes_in_yoke_spacer = [ -12, 12 ];

optical_clearance = 30;   // Clearance at the bottom for the optical system

echo("Coil size: ", coil_height + poke_len, "x",
     fulcrum_distance+fulcrum_dia+fulcrum_ring);
echo("Mount hole distance: ",
     mount_holes_in_yoke_spacer[1] - mount_holes_in_yoke_spacer[0], "mm");

module finger_pad(d=dot_dist,x=dots_x,y=dots_y,thick=fingerpad_thick) {
     color([0.5, 0.5, 0.9, 0.5]) translate([-x*d/2, -y*d/2, 0]) difference() {
	  translate([-1, -1, 0]) cube([x*d + 2, y*d + 2, thick]);
	for (px=[0:x-1]) {
	     for (py=[0:y-1]) {
		  first_half = py < y/2;
		  x_offset = (py-1)*dot_dist/3 - dot_dist * (first_half ? 0 : 1);
		  y_offset = first_half ? -0.3 : 0.3;
		  translate([px*d +d/2 + x_offset,
			     py*d + d/2 + y_offset,
			     -thick/2])
		       scale([1, 1.6]) cylinder(r=dot_dia/2,h=2*thick);
	     }
	}
     }
}

module magnet() {
     color("red") translate([-mag_thick/2,-mag_len/2,0]) cube([mag_thick/2, mag_len, mag_w]);
     color("green") translate([0,-mag_len/2,0]) cube([mag_thick/2, mag_len, mag_w]);
}

module yoke(yoke_height=mag_w, border_thin=0, with_magnet=false, is_bottom=true) {
     extra_bottom = is_bottom ? driver_board_thick : 0;
     difference() {
	  color([0.5, 0.5, 0.5, yoke_transparency])
	       translate([0,0,yoke_height/2 - extra_bottom/2])
	       cube([yoke_width-2*border_thin, yoke_len-2*border_thin, yoke_height + extra_bottom - e], center=true);
	  translate([0,0,yoke_height/2]) cube([center_w + 2*mag_thick + 2*border_thin, mag_len+2*yoke_space + 2*border_thin, yoke_height + 2 * extra_bottom + e], center=true);

	  if (is_bottom) {
	       translate([0,0,-e]) driver_board_assembly(realistic=false);
	  }
     }
     if (with_magnet) {
	  translate([-(center_w+mag_thick)/2, 0, 0]) magnet();
	  translate([+(center_w+mag_thick)/2, 0, 0]) magnet();
     }
}

module coil(poke_pos=0, is_poke) {
     //echo(poke_pos, " -> ", is_poke);
     poke_width=0.8;
     translate([0, fulcrum_distance-0.5, coil_height/2])
     rotate([is_poke ? -poke_angle : 0, 0, 0]) translate([0, -fulcrum_distance+0.5, -coil_height/2])
	  render() difference() {
	  color("yellow")
	       translate([0, (dot_dist-poke_width)/2, 0]) rotate([90, 0, 90])
	       linear_extrude(height=coil_thick, center=true, convexity = 10)
	       import (file = "coil-shape.dxf");
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
     //translate([0, 0, coil_height+poke_len-fingerpad_thick+1.5]) finger_pad();

     rotate([0,0,180]) coil_stack(poke_array=poke_array);

     // The back is rotated and turned, so easy if we just map flipped array
     reflect_array = [for (i = [0:24]) poke_array[23-i]];
     coil_stack(poke_array=reflect_array);
}

module magnet_assembly() {
     yoke(with_magnet=true, is_bottom=true);
     if (top_yoke) translate([0,0,coil_height-mag_w]) rotate([0,0,180]) yoke(with_magnet=true, is_bottom=false);

     fulcrum_len=dots_x * dot_dist + 2*mag_thick;
     color("silver") translate([0, fulcrum_distance, coil_height/2])
	  rotate([0,90,0]) translate([0,0,-fulcrum_len/2]) cylinder(r=fulcrum_dia/2, h=fulcrum_len);
     color("silver") translate([0, -fulcrum_distance, coil_height/2])
	  rotate([0,90,0]) translate([0,0,-fulcrum_len/2]) cylinder(r=fulcrum_dia/2, h=fulcrum_len);
}

module driver_board(realistic=true) {
     rotate([0,0,90]) translate([-driver_board_offset, -driver_board_width/2, 0]) {
	  if (realistic) {
	       color("purple") translate([-70, 66.45, 0])
		    import(file="blisplay-driver.stl");
	  } else {
	       cube([driver_board_len, driver_board_width, driver_board_thick]);
	  }
     }
}

module driver_board_assembly(realistic=true) {
     translate([0, yoke_len/2, -driver_board_thick]) driver_board(realistic);
     translate([0, -yoke_len/2, -driver_board_thick]) rotate([0,0,180]) driver_board(realistic);
}

// TODO: this is a lot of empty space in the yoke-spacer, that we can fill
// with electronics later.
module yoke_spacer() {
     do_tapping = true;  // otherwise overhang.
     mount_dia=do_tapping ? 2.7 : 3.2;
     wiggle_room = 0.25;
     // Leave wiggle-room for magnet on one side, yoke on other
     smaller_yoke_space=yoke_space-2*wiggle_room;
     color("#FFBB00") translate([center_w/2, 0, 0]) {
	  difference() {
	       yoke_outer_wall = (yoke_width - center_w)/2;
	       spacer_high = coil_height - 2*mag_w;
	       translate([0, -yoke_len/2, 0]) cube([yoke_outer_wall, yoke_len, spacer_high]);

	       // Holes for the fulcrum. Not entirely punched through to the end
	       translate([-e, fulcrum_distance, spacer_high/2]) rotate([0,90,0]) #cylinder(r=fulcrum_dia/2+0.2, h=yoke_outer_wall-1);
	       translate([-e, -fulcrum_distance, spacer_high/2]) rotate([0,90,0]) cylinder(r=fulcrum_dia/2+0.2, h=yoke_outer_wall-1);

	       // Tapping holes to mount.
	       for (m = mount_holes_in_yoke_spacer) {
		    translate([-yoke_width/2, m, (coil_height-2*mag_w)/2]) rotate([0,90,0]) cylinder(r=mount_dia/2, h=yoke_width);
		    if (!do_tapping) { // then hole for nut
			 translate([yoke_outer_wall-4, m, 0]) cube([3, 5.4, 30], center=true);
		    }
	       }
	  }

	  // The spacers around the magnets
	  translate([0, yoke_len/2 - yoke_wall - smaller_yoke_space - wiggle_room, -mag_w]) cube([mag_w, smaller_yoke_space, coil_height]);
	  translate([0, -yoke_len/2+yoke_wall + wiggle_room, -mag_w]) cube([mag_w, smaller_yoke_space, coil_height]);
     }
}

module side_wall() {
     bottom_wide = yoke_len + 2*(driver_board_len - driver_board_offset);
     bottom_radius=5;

     difference() {
	  color([0.5, 0.5, 0.5, 0.2]) hull() {
	       translate([0, 0, coil_height/2]) cube([acrylic_t, yoke_len, coil_height], center=true);
	       cube([acrylic_t, bottom_wide, e], center=true);

	       translate([-acrylic_t/2, bottom_wide/2 - bottom_radius, -optical_clearance+bottom_radius]) rotate([0, 90, 0]) cylinder(r=bottom_radius, h=acrylic_t);
	       translate([-acrylic_t/2, -bottom_wide/2 + bottom_radius, -optical_clearance+bottom_radius]) rotate([0, 90, 0]) cylinder(r=bottom_radius, h=acrylic_t);
	  }

	  for (m = mount_holes_in_yoke_spacer) {
	       translate([-acrylic_t/2-e, m, (coil_height-2*mag_w)/2 + mag_w]) rotate([0,90,0]) cylinder(r=3.2/2, h=acrylic_t+2*e);
	  }
     }
}

module print_yoke_spacers() {
     rotate([0, -90, 0]) yoke_spacer();
     translate([15, 5, 0]) rotate([0, -90, 0]) yoke_spacer();
}

// Create a 2D projection of the side-wall to laser-cut.
module lasercut_sidewall() {
     projection(cut = true) rotate([0, 90, 0]) side_wall();
     projection(cut = true) translate([39, 0, 0]) rotate([0, -90, 0]) side_wall();
}

module print_yokes_magnetic_filament() {
     translate([0,0,mag_w]) rotate([0,180,0]) yoke(with_magnet=false, is_bottom=true);
     translate([yoke_width + 2, 0, 0]) yoke(with_magnet=false, is_bottom=false);
}

// In case the yoke is to be printed hollow to be filled with iron filings,
// then a lid put on top.
// Requires support and in general is a little messy.
// Set slicer to 0% infill, no top-shell and support material.
// Generate by explicitly calling
//   make fab/print_yokes_hollow.stl
module print_yokes_hollow() {
     // Bottom with lid
     translate([0,0,driver_board_thick]) yoke(with_magnet=false, is_bottom=true);
     translate([0, yoke_len+2, 0]) yoke(yoke_height=0.4, border_thin=1, is_bottom=false);

     // Top with lid
     translate([yoke_width + 2, 0, 0]) yoke(with_magnet=false, is_bottom=false);
     translate([yoke_width + 2, yoke_len + 2, 0]) yoke(yoke_height=0.4, border_thin=1, is_bottom=false);
}

// Tool to hold up spacer while assembling
module assembly_tool_spacer_holder() {
     bottom_thick=1;
     spacer_high = coil_height - 2*mag_w;
     yoke_outer_wall = (yoke_width - center_w)/2;
     difference() {
	  hull() {
	       translate([0,10,0]) cylinder(r=15, h=bottom_thick);
	       translate([0,-10,0]) cylinder(r=15, h=bottom_thick);
	       translate([0,0,yoke_outer_wall]) cube([spacer_high+2, mag_len-mag_w, 1], center=true);
	  }
	  translate([0,0,10+bottom_thick]) cube([spacer_high+0.2, 60, 20], center=true);
     }
}

// This is how it all looks.
module assembly(poke_array=[]) {
     actuators(poke_array);
     translate([0,0,mag_w]) {
	  yoke_spacer();
	  rotate([0,0,180]) yoke_spacer();
     }
     magnet_assembly();
     driver_board_assembly(true);

     translate([yoke_width/2 + acrylic_t/2, 0, 0]) side_wall();
     translate([-yoke_width/2 - acrylic_t/2, 0, 0]) side_wall();
}

assembly();
