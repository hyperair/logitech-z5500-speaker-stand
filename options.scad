include <MCAD/units/metric.scad>

// leg options
screw_spacing = 75;
leg_thickness = 22;
leg_max_height = 21.5;
leg_length = 38;
clearance = 0.3;
gradient = 10;

legs_overall_size = [
    screw_spacing + leg_thickness,
    screw_spacing + leg_length + leg_thickness / 2,
    leg_max_height
];

screw = M5;
screw_base_thickness = 5;
$fs = 1;
$fa = 1;

// interface options
interface_outer_cylinder_depth = 4;
interface_inner_cylinder_depth = interface_outer_cylinder_depth + 2.35;

interface_inner_cylinder_d = 7.35 - clearance;
interface_outer_cylinder_d = 16 - clearance;
interface_outer_tooth_angle = 100;
interface_face_d = 30;
interface_face_thickness = 1;

interface_overall_height = (interface_outer_cylinder_depth +
    interface_inner_cylinder_depth +
    interface_face_thickness);

interface_ball_d = 2;
interface_ball_orbit_r = 10;

interface_screw_size = M4;
interface_angle = 30;

// mounting cylinder options
mounting_cyl_d1 = 40;
mounting_cyl_h = 40;
mounting_cyl_wall_thickness = 2.8;
