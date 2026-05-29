// Custom Asymmetric 3-Gang Switch Plate
// Layout: [Left: Tap Dial (Shifted)] - [Mid: Decora] - [Right: Decora]
// Units: millimeters

/* [Settings] */
cavity_depth = 6;     
tap_dial_shift = 8.0; 

/* [Hidden] */
number_of_gangs = 3; 

// --- Core Dimensions ---
hole_x_spacing = 46.0;   
internal_width = 73 + ((number_of_gangs - 1) * hole_x_spacing);   
internal_height = 115;  
wall_thickness = 4.0;   
plate_depth = cavity_depth + wall_thickness; 

// Apply the asymmetric shift to the bounding boxes
plate_width = internal_width + (wall_thickness * 2);
plate_height = internal_height + (wall_thickness * 2); // <-- Restored missing height variable
asym_plate_width = plate_width + tap_dial_shift;
asym_internal_width = internal_width + tap_dial_shift;

hole_y_spacing = 96.8;   

// --- Component Specs ---
decora_width = 33.3;
decora_height = 67.1;
dial_cutout_dia = 60.5; 
plate_recess_sq = 66.8;  
plate_recess_depth = 1.0; 
peg_spacing = 52.0;      
peg_dia = 1.725;         
peg_height = 3.0;        

// --- Aesthetics ---
corner_radius = 4.0;     
front_chamfer = 1.5;     
$fn = 60; 

// --- Pre-calculated Positions ---
gang_0_x = (0 - (number_of_gangs - 1) / 2) * hole_x_spacing;
gang_1_x = (1 - (number_of_gangs - 1) / 2) * hole_x_spacing;
gang_2_x = (2 - (number_of_gangs - 1) / 2) * hole_x_spacing;

// --- Custom Modules ---
module rounded_box(w, h, d, r) {
    hull() {
        translate([-w/2 + r, -h/2 + r, 0]) cylinder(r=r, h=d);
        translate([w/2 - r, -h/2 + r, 0]) cylinder(r=r, h=d);
        translate([-w/2 + r, h/2 - r, 0]) cylinder(r=r, h=d);
        translate([w/2 - r, h/2 - r, 0]) cylinder(r=r, h=d);
    }
}

module chamfered_box(w, h, d, r, chamf) {
    hull() {
        translate([0, 0, 0])
            rounded_box(w - 2*chamf, h - 2*chamf, 0.1, r - chamf/2);
        translate([0, 0, chamf])
            rounded_box(w, h, d - chamf, r);
    }
}

module faceplate() {
    union() {
        difference() {
            // 1. Outer Box (Shifted Left)
            translate([-tap_dial_shift / 2, 0, 0])
                chamfered_box(asym_plate_width, plate_height, plate_depth, corner_radius, front_chamfer);
                
            // 2. Hollow out the back (Shifted Left)
            translate([-tap_dial_shift / 2, 0, 0])
                translate([-asym_internal_width/2, -internal_height/2, wall_thickness])
                    cube([asym_internal_width, internal_height, plate_depth + 1]);

            // 3. Wall Box Mounting Holes 
            for(i = [0 : number_of_gangs - 1]) {
                for(y = [-hole_y_spacing/2, hole_y_spacing/2]) {
                    translate([(i - (number_of_gangs - 1) / 2) * hole_x_spacing, y, 0]) {
                        translate([0, 0, -1]) 
                            cylinder(h=plate_depth + 2, d=4, $fn=30); 
                        translate([0, 0, -0.01]) 
                            cylinder(h=3.5, d1=8.5, d2=4, $fn=30); 
                    }
                }
            }

            // 4. Layout Cutouts 
            // --- Gang 0 (Left): Tap Dial (Shifted Left) ---
            translate([gang_0_x - tap_dial_shift, 0, 0]) {
                translate([0, 0, -1])
                    cylinder(h=plate_depth + 2, d=dial_cutout_dia);
                translate([-plate_recess_sq/2, -plate_recess_sq/2, wall_thickness - plate_recess_depth])
                    cube([plate_recess_sq, plate_recess_sq, plate_recess_depth + 0.01]);
            }

            // --- Gang 1 (Middle): Decora (Standard Position) ---
            translate([gang_1_x, 0, wall_thickness/2])
                cube([decora_width, decora_height, wall_thickness + 2], center=true);

            // --- Gang 2 (Right): Decora (Standard Position) ---
            translate([gang_2_x, 0, wall_thickness/2])
                cube([decora_width, decora_height, wall_thickness + 2], center=true);
        }

        // --- Tap Dial Additions (Pegs) ---
        translate([gang_0_x - tap_dial_shift, 0, 0]) {
            for(x = [-peg_spacing/2, peg_spacing/2]) {
                for(y = [-peg_spacing/2, peg_spacing/2]) {
                    translate([x, y, wall_thickness - plate_recess_depth])
                        cylinder(h=peg_height, d=peg_dia, $fn=30);
                }
            }
        }
    }
}

// --- MAIN EXECUTION ---
faceplate();