$fn=96;
loose_fit=0.5;
tight_fit=0.2;
wall_thick=0.5;
wire_space=2;
mag_thick=1.5;
mag_length=19;
mag_width=6.4;

// magnet. centered around x, y; flat on z.
module magnet(extra=0) {
    cube([mag_thick+extra, mag_length+extra, mag_width+extra], center=true);
}

module magnet_punch(extra=0) {
    cube([mag_thick+extra, mag_length+extra, 2 * mag_width + 1 + extra], center=true);
}

module mount_triangle(points=[[0,0],[1,0],[1,1]], depth=1) {
    linear_extrude(height=depth) polygon(points);
}

module spool_holder() {
    translate([0, (mag_length + loose_fit)/2, mag_width/2+wall_thick]) difference() {
	union() {
	    magnet(loose_fit + wall_thick);
	    translate([0, 0, (mag_width + wall_thick)/2]) cube([mag_thick + loose_fit + wall_thick + wire_space, mag_length + loose_fit + wall_thick + wire_space, wall_thick], center=true);
	    translate([0, 0, -(mag_width+wall_thick)/2]) cube([mag_thick + wall_thick + wire_space, mag_length + wall_thick + wire_space, wall_thick], center=true);
	}
	#magnet_punch(loose_fit);
    }
}

module base_plane() {
    difference() {
	cylinder(r=32, h=1);
	for (i=[0:11]) {
	    rotate([0, 0, i * 360/12 + 360/24]) translate([0, 20, -1]) magnet(tight_fit);
	}
    }
}

module spools() {
    for (i=[0:11]) {
	rotate([0, 0, i * 360/12 + 360/24]) translate([0, 10, 0]) spool_holder();
    }
}

module finger_pad(d=2,x=4,y=6,thick=0.7) {
    translate([-x*d/2, -y*d/2, 0]) difference() {
	cube([x*d, y*d, thick]);
	for (px=[0:x-1]) {
	    for (py=[0:y-1]) {
		translate([px*d+d/2, py*d+d/2, -thick/2]) cylinder(r=d/5,h=2*thick);
	    }
	}
    }
}

module spools1() {
    // top left
    translate([-3, 8, 0]) spool_holder();
    translate([-8, 8, 0]) rotate([0, 0, 45]) spool_holder();
    translate([-8, 2.5, 0]) rotate([0, 0, 90]) spool_holder();

    // bottom left.
    translate([-3, -27, 0]) spool_holder();
    translate([-21, -21, 0]) rotate([0, 0, -45]) spool_holder();
    translate([-8, -2.5, 0]) rotate([0, 0, 90]) spool_holder();
}

module ttest() {
    color("red") spool_holder();
    mount_triangle([[-(mag_thick+loose_fit+wire_space)/2, 0],
	    [+(mag_thick+loose_fit+wire_space)/2, 0],
	    [0, -8]], wall_thick);
}
spools();
//color("green") spools1();
translate([0, 0, 8]) color("blue") finger_pad();
//base_plane();
//color("green") scrap();
//mount_triangle();