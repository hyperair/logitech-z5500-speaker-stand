include <options.scad>
use <legs.scad>
use <interface.scad>

include <MCAD/units/metric.scad>

module place_main_cylinder ()
{
    translate ([0, screw_spacing / 2, -5])
    children ();
}

module place_interface ()
{
    place_main_cylinder ()
    translate ([0, 0, mounting_cyl_h])
    rotate (interface_angle, X)
    rotate (90, Z)
    children ();
}

module main_cylinder (outer=true)
{
    height = (outer) ? mounting_cyl_h : mounting_cyl_h + epsilon * 4;
    d1 = ((outer) ? mounting_cyl_d1 :
        mounting_cyl_d1 - mounting_cyl_wall_thickness * 2);
    d2 = ((outer) ? interface_face_d :
        interface_face_d - mounting_cyl_wall_thickness * 2);

    hull () {
        translate ([0, 0, height])
        rotate (interface_angle, X)
        cylinder (d=d2, h=epsilon);

        cylinder (d=d1, h=epsilon);
    }
}

module whole_mount ()
{
    difference () {
        union () {
            legs ();

            place_main_cylinder ()
            main_cylinder ();
        }

        translate ([0, 0, -legs_overall_size[2] /2])
        cube (legs_overall_size, center=true);

        place_main_cylinder ()
        main_cylinder (outer=false);

        place_interface()
        cylinder (d=mounting_cyl_d1, h=100);
    }

    place_interface ()
    translate ([0, 0, -interface_face_thickness])
    interface ();
}

whole_mount ();
