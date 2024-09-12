// Copyright 2024 Maximilian Heim

include <BOSL2-master/std.scad>
include <BOSL2-master/gears.scad>

$fn=70;

// mod = module
// teeth = amount of teeth
// height = height of gear
// diameter_hole = diameter hole through whole part
// hole_filed_distance = how much of the axis is filed off for fixation
// hole_filed_height = height of where the filed off part starts
// screw_radius = radius of fixation screw
// screw_height = height of screw in cylinder
// cylinder_radius = radius of cylinder
// cylinder_height = height of cylinder
module gear(mod, teeth, height, hole_diameter, hole_filed_distance, hole_filed_height, screw_radius, screw_height, cylinder_radius, cylinder_height) {
    
    total_height = height + cylinder_height;
    difference() {
        union() {
            translate([0, 0, height/2])
            spur_gear(mod=mod, teeth=teeth, thickness=height, shaft_diam=0, pressure_angle=24);
            // cylinder on the gear
            translate([0, 0, height])
            cylinder(h=cylinder_height, r=cylinder_radius);
        }
        union() {
            translate([0, 0, 0])
            difference() {
                cylinder(h=total_height, r=hole_diameter / 2);
                translate([hole_diameter/2 - hole_filed_distance, -hole_diameter / 2, hole_filed_height])
                cube([hole_diameter, hole_diameter, total_height - hole_filed_height]);
            }
            // screw
            translate([0, 0, height + screw_height])
            rotate([0, 90, 0])
            cylinder(h=cylinder_radius, r=screw_radius);
        }
    }
}

module filing(height, width, length, diameter, filing) {
    
    difference() {
        translate([-width/2, -length/2, 0])
        cube([width, length, height]);
        translate([width/2 +filing - diameter/2, 0, 0])
        cylinder(h=height, r=diameter/2);
    }
}
//gear(1, 11, 4, 3.6, 0.4, 4, 1.5, 4, 4.1, 7);
//gear(1, 38, 4, 4.53, 1, 0, 0, 0, 4.5, 0);
//translate([0, 0, 4])
//gear(1, 11, 4, 4.53, 1, 0, 0, 0, 0, 0);
filing(150, 8, 8, 4.3, 1);
