include <options.scad>
use <legs.scad>
use <interface.scad>

include <MCAD/units/metric.scad>

module place_main_cylinder ()
{
    translate ([0, screw_spacing / 2 + leg_thickness / 2.5, -5])
    children ();
}

module place_interface ()
{
    face_r = interface_face_d / 2;
    bottom_r = mounting_cyl_d1 / 2;
    height = mounting_cyl_h;

    back_height = sin (interface_angle) * face_r + height;
    back_offset = cos (interface_angle) * face_r - bottom_r;
    target_back_offset = -height / tan (90 - interface_angle);

    translate ([0, -back_offset + target_back_offset, mounting_cyl_h])
    rotate (interface_angle, X)
    rotate (90, Z)
    children ();
}

module main_cylinder (outer=true)
{
    extra_height = (outer) ? 0 : epsilon * 4;
    d1 = ((outer) ? mounting_cyl_d1 :
        mounting_cyl_d1 - mounting_cyl_wall_thickness * 2);
    d2 = ((outer) ? interface_face_d :
        interface_face_d - mounting_cyl_wall_thickness * 2);

    hull () {
        place_interface ()
        translate ([0, 0, extra_height])
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

        translate ([0, 0, -5000])
        cube ([10000, 10000, 10000], center=true);

        place_main_cylinder ()
        main_cylinder (outer=false);

        place_interface()
        cylinder (d=mounting_cyl_d1, h=100);
    }

    place_main_cylinder ()
    place_interface ()
    translate ([0, 0, -interface_face_thickness])
    interface ();
}

whole_mount ();
