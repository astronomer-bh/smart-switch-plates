// Universal Smart Home Switch Plate System - Customizer UI Edition
// Supports: Any combination, easily configured via the Customizer pane
// Units: millimeters

/* [Render Options] */
part_to_print = "Faceplate"; // [Faceplate, Lutron_Bracket]

/* [Wall Plate Settings] */
// Defines the physical size of the plate and screw hole locations
number_of_gangs = 3; // [1:6]
// The internal clearance space to clear existing switch protrusions (Default: 6mm)
cavity_depth = 6; // [2:1:35]

/* [Component 1] */
comp1_type = "Tap_Dial"; // [None, Tap_Dial, Lutron, Decora, Blank]
comp1_pos = 1.5; // [1:0.5:6]

/* [Component 2] */
comp2_type = "Decora"; // [None, Tap_Dial, Lutron, Decora, Blank]
comp2_pos = 3; // [1:0.5:6]

/* [Component 3] */
comp3_type = "None"; // [None, Tap_Dial, Lutron, Decora, Blank]
comp3_pos = 1; // [1:0.5:6]

/* [Component 4] */
comp4_type = "None"; // [None, Tap_Dial, Lutron, Decora, Blank]
comp4_pos = 1; // [1:0.5:6]

/* [Component 5] */
comp5_type = "None"; // [None, Tap_Dial, Lutron, Decora, Blank]
comp5_pos = 1; // [1:0.5:6]

/* [Component 6] */
comp6_type = "None"; // [None, Tap_Dial, Lutron, Decora, Blank]
comp6_pos = 1; // [1:0.5:6]

/* [Hidden] */
// Combine UI variables into an iterable array for the engine
plate_layout = [
    [comp1_type, comp1_pos],
    [comp2_type, comp2_pos],
    [comp3_type, comp3_pos],
    [comp4_type, comp4_pos],
    [comp5_type, comp5_pos],
    [comp6_type, comp6_pos]
];

// --- Core Dimensions ---
hole_x_spacing = 46.0;   
internal_width = 73 + ((number_of_gangs - 1) * hole_x_spacing);   
internal_height = 115;  
wall_thickness = 4.0;   
plate_depth = cavity_depth + wall_thickness; // Automatically calculates total depth
plate_width = internal_width + (wall_thickness * 2);
plate_height = internal_height + (wall_thickness * 2);
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

// --- Lutron Bracket Specs ---
shelf_width = 10.1;       
shelf_thickness = 2.0;    
shelf_depth = 8.0;        
screw_hole_offset = 13.5; 
boss_dia = 6.0;           
boss_depth = 3.0;         
wing_thickness = 1.5;     
wing_height = 6.0;        
screw_hole_dia = 3.3;     
nut_waf = 5.6;            
nut_thickness = 2.6;      
nut_dia = nut_waf / cos(30); 
insert_width = 16.0;      
insert_height = 24.0;     
flange_margin = 2.0;      
snap_bump = 0.44;         

// --- Aesthetics ---
corner_radius = 4.0;     
front_chamfer = 1.5;     
$fn = 60; 

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

// --- Component Generation ---
module faceplate() {
    union() {
        difference() {
            // 1. Outer Box 
            chamfered_box(plate_width, plate_height, plate_depth, corner_radius, front_chamfer);
                
            // 2. Hollow out the back 
            translate([-internal_width/2, -internal_height/2, wall_thickness])
                cube([internal_width, internal_height, plate_depth + 1]);

            // 3. Wall Box Mounting Holes
            for(i = [0 : number_of_gangs - 1]) {
                gang_x_pos = (i - (number_of_gangs - 1) / 2) * hole_x_spacing;
                for(y = [-hole_y_spacing/2, hole_y_spacing/2]) {
                    translate([gang_x_pos, y, 0]) {
                        translate([0, 0, -1]) 
                            cylinder(h=plate_depth + 2, d=4, $fn=30); 
                        translate([0, 0, -0.01]) 
                            cylinder(h=3.5, d1=8.5, d2=4, $fn=30); 
                    }
                }
            }

            // 4. Layout Cutouts 
            for(comp = plate_layout) {
                if (comp[0] != "None") {
                    // Convert user's 1-indexed position (e.g., 1.5) to internal coordinates
                    comp_x_center = (comp[1] - 1 - (number_of_gangs - 1) / 2) * hole_x_spacing;
                    
                    translate([comp_x_center, 0, 0]) {
                        if (comp[0] == "Decora") {
                            translate([0, 0, wall_thickness/2])
                                cube([decora_width, decora_height, wall_thickness + 2], center=true);
                        } 
                        else if (comp[0] == "Lutron") {
                            translate([0, 0, wall_thickness/2])
                                cube([insert_width + 0.2, insert_height + 0.2, wall_thickness + 2], center=true);
                        }
                        else if (comp[0] == "Tap_Dial") {
                            translate([0, 0, -1])
                                cylinder(h=plate_depth + 2, d=dial_cutout_dia);
                            translate([-plate_recess_sq/2, -plate_recess_sq/2, wall_thickness - plate_recess_depth])
                                cube([plate_recess_sq, plate_recess_sq, plate_recess_depth + 0.01]);
                        }
                    }
                }
            }
        }

        // --- Layout Additions (Pegs) ---
        for(comp = plate_layout) {
            if (comp[0] == "Tap_Dial") {
                comp_x_center = (comp[1] - 1 - (number_of_gangs - 1) / 2) * hole_x_spacing;
                translate([comp_x_center, 0, 0]) {
                    for(x = [-peg_spacing/2, peg_spacing/2]) {
                        for(y = [-peg_spacing/2, peg_spacing/2]) {
                            translate([x, y, wall_thickness - plate_recess_depth])
                                cylinder(h=peg_height, d=peg_dia, $fn=30);
                        }
                    }
                }
            }
        }
    }
}

module lutron_bracket() {
    difference() {
        union() {
            translate([0, 0, 0.5]) cube([insert_width + flange_margin*2, insert_height + flange_margin*2, 1.0], center=true);
            translate([0, 0, 1.0 + wall_thickness/2]) cube([insert_width, insert_height, wall_thickness], center=true);
            translate([0, 0, 1.0 + wall_thickness]) hull() {
                cube([insert_width + snap_bump*2, insert_height, 0.1], center=true);
                translate([0, 0, 0.8]) cube([insert_width - 1.0, insert_height, 0.1], center=true);
            }
            translate([0, insert_height/2 - 4, 1.0 + wall_thickness + shelf_depth/2]) cube([shelf_width, shelf_thickness, shelf_depth], center=true);
            for(x = [-shelf_width/2 + wing_thickness/2, shelf_width/2 - wing_thickness/2]) {
                translate([x, (insert_height/2 - 4) + shelf_thickness/2 - wing_height/2, 1.0 + wall_thickness + shelf_depth/2])
                    cube([wing_thickness, wing_height, shelf_depth], center=true);
            }
            translate([0, (insert_height/2 - 4) - screw_hole_offset, 1.0 + wall_thickness]) cylinder(h=boss_depth, d=boss_dia);
        }
        translate([0, (insert_height/2 - 4) - screw_hole_offset, -1]) cylinder(h=1.0 + wall_thickness + boss_depth + 2, d=screw_hole_dia);
        translate([0, (insert_height/2 - 4) - screw_hole_offset, -0.01]) cylinder(h=nut_thickness + 0.01, d=nut_dia, $fn=6);
    }
}

// --- MAIN EXECUTION ---
if (part_to_print == "Faceplate") {
    faceplate();
} else if (part_to_print == "Lutron_Bracket") {
    lutron_bracket();
}