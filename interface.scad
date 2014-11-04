include <MCAD/units/metric.scad>
include <options.scad>
use <MCAD/shapes/polyhole.scad>
use <MCAD/shapes/2Dshapes.scad>

module interface ()
{
    difference () {
        union () {
            translate ([0, 0, interface_face_thickness - epsilon]) {
                // inner cylinder
                cylinder (d=interface_inner_cylinder_d,
                    h=interface_inner_cylinder_depth);

                // outer cylinder
                linear_extrude (height=interface_outer_cylinder_depth)
                intersection () {
                    circle (d=interface_outer_cylinder_d);
                    pieSlice (size=interface_outer_cylinder_d,
                        start_angle=-interface_outer_tooth_angle / 2,
                        end_angle=interface_outer_tooth_angle / 2);
                }
            }

            cylinder (d=interface_face_d, h=interface_face_thickness);

            translate ([-interface_ball_orbit_r, 0, interface_face_thickness])
            sphere (d=interface_ball_d);
        }

        translate ([0, 0, -epsilon * 2]) {
            // center bore
            polyhole (d=interface_screw_size + clearance,
                h=interface_overall_height + epsilon * 3);

            // trough for ratcheting ball
            for (i=[1, -1])
            translate ([-interface_ball_orbit_r, i * interface_ball_d / 2, 0])
            rotate (i * 15, Z)
            translate ([0, (i < 0) ? -1 : 0, 0])
            cube ([5, 1, interface_face_thickness + epsilon * 4]);

            translate ([-interface_ball_orbit_r, 0, 0])
            linear_extrude (height=interface_face_thickness + epsilon * 4)
            intersection () {
                difference () {
                    circle (d=interface_ball_d + 1 * 2);

                    translate ([0, 0, -epsilon])
                    circle (d=interface_ball_d);
                }

                pieSlice (size=interface_ball_d + 1 * 2,
                    start_angle = 180 - 90,
                    end_angle = 180 + 90);
            }
        }
    }
}

interface ();
