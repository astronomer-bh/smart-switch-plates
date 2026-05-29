/* [Wall Plate Settings] */
number_of_gangs = 3; // [1:6]
plate_depth = 19;    // Total depth (15mm cavity + 4mm face)

/* [Dimensions based on your measurements] */
internal_width = 165;   // 164mm plate + 1mm clearance
internal_height = 115;  // 114mm plate + 1mm clearance
dial_cutout_dia = 60.5; // 59.75mm dial + 0.75mm clearance

/* [Hidden] */
wall_thickness = 4.0;   
plate_width = internal_width + (wall_thickness * 2);
plate_height = internal_height + (wall_thickness * 2);

hole_x_spacing = 46.0;   
hole_y_spacing = 96.8;   

// Metal Plate Specs
plate_recess_sq = 66.8;  
plate_recess_depth = 1.0; 
peg_spacing = 52.0;      
peg_dia = 1.725;         
peg_height = 3.0;        

// Aesthetics
corner_radius = 4.0;     // X/Y outer corner rounding
front_chamfer = 1.5;     // Z-edge chamfer 

$fn = 100; // Smooth curves

// --- Custom Modules for Aesthetics ---

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

// --- Model Generation ---
union() {
    difference() {
        // 1. Outer Box (Rounded outside)
        chamfered_box(plate_width, plate_height, plate_depth, corner_radius, front_chamfer);
            
        // 2. Hollow out the back (Squared inside for maximum clearance)
        translate([-internal_width/2, -internal_height/2, wall_thickness])
            cube([internal_width, internal_height, plate_depth + 1]);

        // 3. Center Hole for the Hue Dial
        translate([0, 0, -1])
            cylinder(h=plate_depth + 2, d=dial_cutout_dia);
            
        // 4. Square Recess for the metal plate
        translate([-plate_recess_sq/2, -plate_recess_sq/2, wall_thickness - plate_recess_depth])
            cube([plate_recess_sq, plate_recess_sq, plate_recess_depth + 0.01]);
            
        // 5. Screw Holes and Countersinks
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
    }

    // 6. Alignment Pegs for the metal plate
    for(x = [-peg_spacing/2, peg_spacing/2]) {
        for(y = [-peg_spacing/2, peg_spacing/2]) {
            translate([x, y, wall_thickness - plate_recess_depth])
                cylinder(h=peg_height, d=peg_dia, $fn=30);
        }
    }
}