screw_spacing = 75;
leg_thickness = 22;
leg_max_height = 21.5;
leg_length = 50;
clearance = 0.3;
gradient = 5;
$fs = 1;
$fa = 1;

overall_size = [
    screw_spacing + leg_thickness,
    screw_spacing + leg_length + leg_thickness / 2,
    leg_max_height
];

include <MCAD/units/metric.scad>

use <MCAD/shapes/2Dshapes.scad>
use <MCAD/shapes/polyhole.scad>

screw = M5;
screw_base_thickness = 5;

module legs ()
{
    difference () {
        linear_extrude (height=leg_max_height) {
            donutSlice (innerSize=screw_spacing / 2 - leg_thickness / 2,
                outerSize=screw_spacing / 2 + leg_thickness / 2,
                start_angle=0,
                end_angle=180);

            for (i=[1, -1]) {
                translate ([-leg_thickness / 2 + i * screw_spacing / 2, -leg_length])
                square ([leg_thickness, leg_length]);

                translate ([i * screw_spacing / 2, -leg_length])
                circle (d=leg_thickness);
            }
        }

        // screw holes
        for (i=[1, -1])
        translate ([i  * screw_spacing / 2, -leg_length, 0]) {
            translate ([0, 0, -epsilon * 2])
            polyhole (d=screw + clearance, h=1000);

            translate ([0, 0, screw_base_thickness])
            polyhole (d=screw * 1.8 + clearance, h=1000);
        }

        translate ([0, overall_size[1] / 2, overall_size[2]])
        rotate (gradient, X)
        translate ([-overall_size[0] / 2 - epsilon, -overall_size[1] - epsilon * 2, 0])
        cube (overall_size + [epsilon * 2, epsilon * 2, 100]);
    }
}

legs ();
