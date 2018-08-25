$fn=32;
e=0.01;

mag_len=1.5*25.4;
mag_w=25.4/4;
mag_thick=25.4/4;

dots_x=4;
dots_y=6;
dot_dist=2;
dot_dia=1;

coil_height=3*mag_w;
coil_thick=0.4;
coil_short=0;  // leave space to move at end.. typically !needed b/c yoke_space

top_yoke=true;
yoke_thick=mag_w;  // Good size to capture all magnets.
yoke_space=4;   // Space around magnets.

center_w=dots_x * dot_dist;
yoke_width = center_w + 2*mag_thick+2*yoke_thick;
yoke_len = mag_len + 2*yoke_thick + 2*yoke_space;

poke_len=2;
fingerpad_thick=0.7;

fulcrum_dia=2;
fulcrum_ring=1;
fulcrum_distance=(mag_len + yoke_thick)/2 + yoke_space;

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

module yoke(with_magnet=true) {
     difference() {
	  color([0.5, 0.5, 0.5, 0.6]) translate([0,0,mag_w/2]) cube([yoke_width, yoke_len, mag_w-e], center=true);
	  translate([0,0,mag_w/2]) cube([center_w + 2*mag_thick, mag_len+2*yoke_space, mag_w+2], center=true);
     }
     if (with_magnet) {
	  translate([-(center_w+mag_thick)/2, 0, 0]) magnet();
	  translate([+(center_w+mag_thick)/2, 0, 0]) magnet();
     }
}

module coil(poke_pos=0) {
     poke_width=0.8;
     difference() {
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
     //translate([0, 0, coil_height+poke_len-fingerpad_thick-0.2]) finger_pad();

     translate([-1.5*dot_dist, 0, 0]) coil_triplet();
     translate([-0.5*dot_dist, 0, 0]) coil_triplet();
     translate([0.5*dot_dist, 0, 0]) coil_triplet();
     translate([1.5*dot_dist, 0, 0]) coil_triplet();
}

module actuators() {
     rotate([0,0,180]) coil_stack();
     coil_stack();
}

module magnet_assembly() {
     yoke();
     if (top_yoke) translate([0,0,coil_height-mag_w]) rotate([0,0,180]) yoke();

     fulcrum_len=dots_x * dot_dist + 2*mag_thick;
     color("silver") translate([0, fulcrum_distance, coil_height/2])
	  rotate([0,90,0]) translate([0,0,-fulcrum_len/2]) cylinder(r=fulcrum_dia/2, h=fulcrum_len);
     color("silver") translate([0, -fulcrum_distance, coil_height/2])
	  rotate([0,90,0]) translate([0,0,-fulcrum_len/2]) cylinder(r=fulcrum_dia/2, h=fulcrum_len);
}

//actuators();
//magnet_assembly();

//yoke(false);

module yoke_spacer() {
     smaller_yoke_space=yoke_space-0.3;
     translate([center_w/2, 0, 0]) {
	  difference() {
	       translate([0, -yoke_len/2, 0]) cube([2*mag_w, yoke_len, mag_w]);
	       translate([-yoke_width/2, fulcrum_distance, (coil_height-2*mag_w)/2]) rotate([0,90,0]) cylinder(r=fulcrum_dia/2+0.2, h=yoke_width);
	       translate([-yoke_width/2, -fulcrum_distance, (coil_height-2*mag_w)/2]) rotate([0,90,0]) cylinder(r=fulcrum_dia/2+0.2, h=yoke_width);
	  }
	  translate([0, yoke_len/2 - yoke_thick - smaller_yoke_space, 0]) cube([mag_w, smaller_yoke_space, 2*mag_w]);
	  translate([0, -yoke_len/2+yoke_thick, 0]) cube([mag_w, smaller_yoke_space, 2*mag_w]);
     }
}

//translate([0,0,mag_w]) yoke_spacer();
//rotate([0,0,180]) translate([0,0,mag_w]) yoke_spacer();
magnet_assembly();
actuators();

//yoke_spacer();
