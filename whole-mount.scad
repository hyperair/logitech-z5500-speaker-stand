include <options.scad>
use <legs.scad>
use <interface.scad>

include <MCAD/units/metric.scad>

module place_main_cylinder ()
{
    translate ([0, screw_spacing / 2, -5])
    rotate (10, X)
    children ();
}

module whole_mount ()
{
    mounting_cyl_d1 = 40;
    mounting_cyl_d2 = 30;
    mounting_cyl_h = 50;
    mounting_cyl_wall_thickness = 5;

    difference () {
        union () {
            legs ();

            place_main_cylinder ()
            cylinder (d1=40, d2=30, h=50);
        }

        translate ([0, 0, -legs_overall_size[2] /2])
        cube (legs_overall_size, center=true);

        place_main_cylinder ()
        translate ([0, 0, -epsilon])
        cylinder (d1=mounting_cyl_d1 - mounting_cyl_wall_thickness * 2,
            d2=mounting_cyl_d2 - mounting_cyl_wall_thickness * 2,
            h=mounting_cyl_h + epsilon * 4);
    }

    place_main_cylinder ()
    translate ([0, 0, mounting_cyl_h - interface_face_thickness])
    rotate (90, Z)
    interface ();
}

whole_mount ();
