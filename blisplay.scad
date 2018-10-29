$fn=32;
e=0.01;

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
yoke_wall=1.2*mag_w;  // Large enough to capture most field-lines.
yoke_space=4;          // Space around magnets.
yoke_transparency = 1;

center_w=dots_x * dot_dist;
yoke_width = max(center_w + 2*mag_thick+2*yoke_wall,
		 driver_board_space_needed);
yoke_len = mag_len + 2*yoke_wall + 2*yoke_space;

poke_len=2;
fingerpad_thick=0.7;

fulcrum_dia=2;
fulcrum_ring=1;
fulcrum_distance=(mag_len + yoke_wall)/2 + yoke_space;

echo("Coil size: ", coil_height + poke_len, "x",
     fulcrum_distance+fulcrum_dia+fulcrum_ring);

module finger_pad(d=dot_dist,x=dots_x,y=dots_y,thick=fingerpad_thick) {
     color([0.5, 0.5, 0.9, 0.5]) translate([-x*d/2, -y*d/2, 0]) difference() {
	cube([x*d, y*d, thick]);
	for (px=[0:x-1]) {
	    for (py=[0:y-1]) {
		translate([px*d+d/2, py*d+d/2, -thick/2]) cylinder(r=dot_dia/2,h=2*thick);
	    }
	}
    }
}

module magnet() {
     color("red") translate([-mag_thick/2,-mag_len/2,0]) cube([mag_thick/2, mag_len, mag_w]);
     color("green") translate([0,-mag_len/2,0]) cube([mag_thick/2, mag_len, mag_w]);
}

module yoke(with_magnet=false, is_bottom=true) {
     extra_bottom = is_bottom ? driver_board_thick : 0;
     difference() {
	  color([0.5, 0.5, 0.5, yoke_transparency]) translate([0,0,mag_w/2 - extra_bottom/2]) cube([yoke_width, yoke_len, mag_w + extra_bottom - e], center=true);
	  translate([0,0,mag_w/2]) cube([center_w + 2*mag_thick, mag_len+2*yoke_space, mag_w + 2 * extra_bottom + e], center=true);

	  if (is_bottom) {
	       translate([0,0,-e]) driver_board_assembly(realistic=false);
	  }
     }
     if (with_magnet) {
	  translate([-(center_w+mag_thick)/2, 0, 0]) magnet();
	  translate([+(center_w+mag_thick)/2, 0, 0]) magnet();
     }
}

module coil(poke_pos=0) {
     poke_width=0.8;
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

module coil_triplet() {
     translate([-dot_dist/3, 0, 0]) coil(0);
     angle = 0;
     translate([0, fulcrum_distance, coil_height/2]) rotate([angle,0,0])
	  translate([0, -fulcrum_distance, -coil_height/2]) coil(1);
     translate([dot_dist/3, 0, 0]) coil(2);
}

module coil_stack() {
     offset = (dots_x-1) * dot_dist / 2.0;
     for (i = [0:1:dots_x-e]) {
	  translate([i * dot_dist - offset, 0, 0]) coil_triplet();
     }
}

module actuators() {
     //translate([0, 0, coil_height+poke_len-fingerpad_thick-0.2]) finger_pad();

     rotate([0,0,180]) coil_stack();
     coil_stack();
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

module yoke_spacer() {
     // TODO: this is a lot of empty space that we can fill with electronics.
     smaller_yoke_space=yoke_space-0.3;
     color("#FFBB00") translate([center_w/2, 0, 0]) {
	  difference() {
	       yoke_outer_wall = (yoke_width - center_w)/2;
	       spacer_high = coil_height - 2*mag_w;
	       translate([0, -yoke_len/2, 0]) cube([yoke_outer_wall, yoke_len, spacer_high]);

	       // Holes for the fulcrum
	       translate([-yoke_width/2, fulcrum_distance, (coil_height-2*mag_w)/2]) rotate([0,90,0]) cylinder(r=fulcrum_dia/2+0.2, h=yoke_width);
	       translate([-yoke_width/2, -fulcrum_distance, (coil_height-2*mag_w)/2]) rotate([0,90,0]) cylinder(r=fulcrum_dia/2+0.2, h=yoke_width);
	  }

	  // The spacers around the magnets
	  translate([0, yoke_len/2 - yoke_wall - smaller_yoke_space, -mag_w]) cube([mag_w, smaller_yoke_space, coil_height]);
	  translate([0, -yoke_len/2+yoke_wall, -mag_w]) cube([mag_w, smaller_yoke_space, coil_height]);
     }
}

module assembly() {
     actuators();
     translate([0,0,mag_w]) {
	  yoke_spacer();
	  rotate([0,0,180]) yoke_spacer();
     }
     magnet_assembly();
     driver_board_assembly(true);
}

assembly();
//yoke_spacer();
