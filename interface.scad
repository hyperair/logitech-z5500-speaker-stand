include <MCAD/units/metric.scad>
include <options.scad>
use <MCAD/shapes/polyhole.scad>
use <MCAD/shapes/2Dshapes.scad>

module interface ()
{
    outer_cylinder_depth = 4;
    inner_cylinder_depth = outer_cylinder_depth + 2.35;

    inner_cylinder_d = 7.35 - 0.3;
    outer_cylinder_d = 16 - 0.3;
    outer_tooth_angle = 100;
    face_d = 30;
    face_thickness = 2;

    overall_height = (outer_cylinder_depth + inner_cylinder_depth +
        face_thickness);

    ball_d = 3;
    ball_orbit_r = 11;

    difference () {
        union () {
            translate ([0, 0, face_thickness - epsilon]) {
                // inner cylinder
                cylinder (d=inner_cylinder_d, h=inner_cylinder_depth);

                // outer cylinder
                linear_extrude (height=outer_cylinder_depth)
                intersection () {
                    circle (d=outer_cylinder_d);
                    pieSlice (size=outer_cylinder_d,
                        start_angle=-outer_tooth_angle / 2,
                        end_angle=outer_tooth_angle / 2);
                }
            }

            cylinder (d=face_d, h=face_thickness);

            translate ([-ball_orbit_r, 0, face_thickness])
            sphere (d=ball_d);
        }

        translate ([0, 0, -epsilon * 2]) {
            // center bore
            polyhole (d=M4 + 0.3, h=overall_height + epsilon * 3);

            // trough for ratcheting ball
            for (i=[1, -1])
            translate ([-ball_orbit_r, i * ball_d / 2, 0])
            rotate (i * 15, Z)
            translate ([0, (i < 0) ? -1 : 0, 0])
            cube ([5, 1, face_thickness + epsilon * 4]);

            translate ([-ball_orbit_r, 0, 0])
            linear_extrude (height=face_thickness + epsilon * 4)
            intersection () {
                difference () {
                    circle (d=ball_d + 1 * 2);

                    translate ([0, 0, -epsilon])
                    circle (d=ball_d);
                }

                pieSlice (size=ball_d + 1 * 2,
                    start_angle = 180 - 90,
                    end_angle = 180 + 90);
            }
        }
    }
}

interface ();
