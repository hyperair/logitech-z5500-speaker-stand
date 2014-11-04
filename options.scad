include <MCAD/units/metric.scad>

screw_spacing = 75;
leg_thickness = 22;
leg_max_height = 21.5;
leg_length = 50;
clearance = 0.3;
gradient = 5;

overall_size = [
    screw_spacing + leg_thickness,
    screw_spacing + leg_length + leg_thickness / 2,
    leg_max_height
];

screw = M5;
screw_base_thickness = 5;
$fs = 1;
$fa = 1;
