//===================================================================================
// Parametric PCB Standoff Spacer OpenSCAD script
//
// Copyright (c) 2016 Mark David Seminatore
//
// Refer to included LICENSE.txt for usage rights and restrictions
//===================================================================================
//

/* [Build Plate] */
/*
use <utils/build_plate.scad>

//set your build plate
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//if set to "manual" set the  build plate x dimension
build_plate_manual_x = 100; //[100:400]

//if set to "manual" set the  build plate y dimension
build_plate_manual_y = 100; //[100:400]

build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);
*/

/* [Spacer] */

// Height of spacer
spacer_height = 0.5;   // [0.25 : 0.125 : 1]

// Standard screw diameter
screw_size = 0.1120;  // [0.112:#4, 0.125:#5, 0.138:#6, 0.164:#8, 0.19:#10, 0.216:#12, 0.25:1/4", 0.375:3/8"]

// Number of spacers
spacer_count = 1;   // [1:25]

// Separation factor
separation_factor = 1.25;   // [1: 0.05: 2]

//
// calculated values
//

// Diameter of spacer
spacer_diameter = screw_size * 3;

// Separation between spacers
separation = spacer_diameter * separation_factor;

/* [Hidden] */

$fs = 0.01;

// instantiate an array of spacer objects
columns = ceil(sqrt(spacer_count));
rows = ceil(spacer_count / columns);

for (row = [1 : rows]) {
    for (col = [1 : columns]) {
        count = (row - 1) * columns + col;

        if (count <= spacer_count) {
            translate([(col - 1) * separation, -(row - 1) * separation, 0])
                mdsSpacer(spacer_height, spacer_diameter, screw_size);
        }
    }
}


//
//
//
module mdsSpacer(height, dia, hole) {
    linear_extrude(height = height)
        difference() {
            circle(d = dia);
            circle(d = hole);
        }
}