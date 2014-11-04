include <MCAD/units/metric.scad>
include <options.scad>

use <MCAD/shapes/2Dshapes.scad>
use <MCAD/shapes/polyhole.scad>

module legs ()
{
    difference () {
        translate ([0, screw_spacing / 2 + leg_thickness / 2, 0])
        rotate (gradient, X)
        translate ([0, -(screw_spacing / 2 + leg_thickness / 2), 0])
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

        // cut off z<0
        translate ([0, 0, -5000])
        cube ([10000, 10000, 10000], center=true);
    }
}

legs ();
