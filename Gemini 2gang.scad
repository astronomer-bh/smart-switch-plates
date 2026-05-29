/* [Wall Plate Settings] */

// Number of switches (gangs)
number_of_gangs = 3; // [1:6]

// Total thickness from wall (mm)
plate_depth = 12; // [8:1:20]


/* [Hidden] */
// --- Calculated Dimensions ---
// OpenSCAD will hide these from the Customizer UI
hole_x_spacing = 46.0;   
// Dynamically calculate width: 74mm base + 46mm for each additional switch
plate_width = 74 + ((number_of_gangs - 1) * hole_x_spacing);       
plate_height = 120;
wall_thickness = 2.5;    
hole_y_spacing = 96.8;   

dial_cutout_dia = 48.5;  

// Metal Plate Specs
plate_recess_sq = 66.8;  
plate_recess_depth = 1.0; 
peg_spacing = 52.0;      
peg_dia = 2.3;           
peg_height = 3.0;        

$fn = 100; // Smooth curves

// --- Model Generation ---
union() {
    difference() {
        // 1. Outer Box
        translate([0, 0, plate_depth/2])
            cube([plate_width, plate_height, plate_depth], center=true);
            
        // 2. Hollow out the back
        translate([0, 0, (plate_depth - wall_thickness)/2])
            cube([plate_width - wall_thickness*2, plate_height - wall_thickness*2, plate_depth - wall_thickness], center=true);

        // 3. Center Hole to reveal the metal plate
        translate([0, 0, -1])
            cylinder(h=plate_depth + 2, d=dial_cutout_dia);
            
        // 4. Square Recess for the metal plate (on the inside face)
        translate([0, 0, plate_depth - wall_thickness + plate_recess_depth/2])
            cube([plate_recess_sq, plate_recess_sq, plate_recess_depth + 0.01], center=true);
            
        // 5. Screw Holes and Countersinks (Dynamically generated)
        for(i = [0 : number_of_gangs - 1]) {
            for(y = [-hole_y_spacing/2, hole_y_spacing/2]) {
                // Calculate the X position for this specific switch gang
                translate([(i - (number_of_gangs - 1) / 2) * hole_x_spacing, y, -1])
                    cylinder(h=plate_depth + 2, d=4, $fn=30); 
                // Countersink for flush screw heads
                translate([(i - (number_of_gangs - 1) / 2) * hole_x_spacing, y, plate_depth - 2.5])
                    cylinder(h=3.5, d1=4, d2=8.5, $fn=30); 
            }
        }
    }

    // 6. Alignment Pegs for the metal plate
    for(x = [-peg_spacing/2, peg_spacing/2]) {
        for(y = [-peg_spacing/2, peg_spacing/2]) {
            // Pegs drop down from the ceiling of the square recess
            translate([x, y, plate_depth - wall_thickness + plate_recess_depth - peg_height])
                cylinder(h=peg_height + 1, d=peg_dia, $fn=30);
        }
    }
}