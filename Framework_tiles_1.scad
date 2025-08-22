// Framework Desktop Tile
// Copyright (c) 2025 Charles Guldenschuh
//
//
// Framework github repository:
//
//      https://github.com/FrameworkComputer/Framework-Desktop
// 
// All dimensions from /Tiles/FRAMEWORK_DESKTOP_BLANK_TILE_V0.pdf
//
// Inspiration for the base from:
//
//  https://github.com/CavinWeber/FrameworkTiles
//
// The base tile here starts from:
//
//  https://github.com/FrameworkComputer/Framework-Desktop/Tiles/FRAMEWORK_DESKTOP_BLANK_TILE.stp
//
// Base tile size

/* [Build Selection] */

// Add skeletonized mounts
bMount = true;
// Mount style
bMStyle = 0;    // [0:Skeleton, 1:Blocking, 2:Solid]
// Blank tile
bBlank = false;
// Horizontal slats
bHorizontal = false;
// Diagonal slats
bDiagonal = false;
// Crosshatch slats
bCrosshatch = false;
// Lattice slats
bLattice = false;
// Sunburst slats
bSunburst = false;
// Diamond lattice
bDiamond = false;
// Honeycomb - normal size tile
bHoneycomb = false;
// Skeletonized base
bBase = false;
// Multi tile honeycomb
bHoneycombMulti = false;
// Multi tile honeycomb size
bHC_w = 3;  // [1:3]
bHC_h = 2;  // [1:7]
// Large Honeycomb mount style
bHC_mstyle = 1; // [0:None, 1:Corners, 2:All]
// Multi tile blank
bMBlank = false;
// Multi blank size
bMB_w = 3;  // [1:3]
bMB_h = 2;  // [1:7]
// Multi blank mount style
bMB_style = 1;  // [0:None, 1:Corners, 2:All, 3:Specified]
// Mount locations X
bMB_basex = [0, 0, 0, 0, 0, 0, 0];
// Mount locations Y
bMB_basey = [0, 0, 0, 0, 0, 0, 0];

// Faceplate - WIP
bFaceplate = false;
/* [Test] */
// Whatever is currently being tested
bTest = false;

/* [Hidden] */
// Tile size DO NOT CHANGE
TWIDTH = 28.45;
TDEPTH = 28.45;

// Faceplate size - WIP Height not guarenteed
FACEPLATE_WIDTH = 96.8;
FACEPLATE_HEIGHT = 214.3;   // (226.1 - 6.8 - 5?)
CUTOUT = 20;

/* [Build size parameters] */

// Face thickness
TFACE = 1;   // [.2:.2:3]
// Tile border size
TBORDER = 1.1; // [0:.1:3]
// Number of slats
GRIDCNT = 10;
GRIDGAP = ((TWIDTH - (TBORDER*2)*0) / (GRIDCNT*2+1));
//GRIDGAP = ((TWIDTH - (TBORDER*2)) / GRIDCNT);
// Honeycomb Inner radius
radi = 1.0;
// Honeycomb Outer radius
rado = 1.15;


//
// WIP: The faceplate for mounting the tiles
// TODO: Power switch
// TODO: Diagonal latch points
// TODO: Upper/lower alignment holes
//
module face_plate() {
    offsetx = (FACEPLATE_WIDTH - (TWIDTH * 3)) / 2;
    offsety = (FACEPLATE_HEIGHT - (TDEPTH * 7)) * 2 / 3;
    offsetc = (TWIDTH - CUTOUT) / 2;
    alignx = 2.0;
    aligny = 3.5;
    difference() {
        // The faceplate
        cube([FACEPLATE_WIDTH, FACEPLATE_HEIGHT, 4]);
        // The depression for the tiles
        translate([offsetx, offsety, 1.2]) cube([TWIDTH*3, TDEPTH*7, 4]);
        for (x=[0:2], y=[0:6]) {
            // Empty center
            translate([offsetx + TWIDTH * x + offsetc, offsety + TDEPTH * y + offsetc, 0])
                cube([CUTOUT, CUTOUT, 4]);
            // Alignment holes left and right
            translate([.2+offsetx + TWIDTH * x, TDEPTH*y+(TDEPTH)/2-aligny/2+offsety, 0]) 
                cube([alignx, aligny, 4]);
            translate([TWIDTH+offsetx-(-.95+aligny) +TWIDTH*x, TDEPTH*y + (TDEPTH)/2-aligny/2+offsety, 0]) 
                cube([alignx, aligny, 4]);
            // Alignment holes top and bottom
            translate([offsetx+TWIDTH/2-1.8+TWIDTH*x, offsety+.5+TDEPTH*y, 0])
                cube([aligny, alignx, 4]);
            translate([offsetx+TWIDTH/2-1.8+TWIDTH*x, offsety+TDEPTH-aligny+1+TDEPTH*y, 0])
                cube([aligny, alignx, 4]);
        }
    }
}

module do_test() {
    translate([-(FACEPLATE_WIDTH+4), 0, 0]) {
        offsety = (FACEPLATE_HEIGHT - (TDEPTH * 6)) * 2 / 3 + 9.5;
        sbase(type=1);
        //translate([(TWIDTH-CUTOUT)/2, (TWIDTH-CUTOUT)/2, 0]) #cube([CUTOUT, CUTOUT, 1]);
        // New part of base
//        {
//            widthb = (TWIDTH - (CUTOUT * 1)) / 2 * 1 - TBORDER;
//            lenb = TDEPTH - (TBORDER*2);
//            translate([TBORDER, TBORDER, 0]) {
//                #cube([widthb, lenb, TFACE+.4]);
//                #cube([lenb, widthb, TFACE+.4]);
//            }
//            translate([TBORDER+CUTOUT+widthb, TBORDER, 0]) {
//                #cube([widthb, lenb, TFACE+.4]);
//            }
//            translate([TBORDER, TDEPTH-widthb-TBORDER, 0])    #cube([lenb, widthb, TFACE+.5]);
//        }
    }
}

// Blank tile
module blank() {
    cube([TWIDTH, TDEPTH, TFACE]);
}

// Horizontal/Vertical slats
module straight() {
    difference() {
        cube([TWIDTH, TDEPTH, TFACE]);
        for (i = [GRIDGAP:GRIDGAP*2:TWIDTH-(GRIDGAP)]) {
            translate([i, TBORDER, -.01]) cube([GRIDGAP, TDEPTH-(TBORDER*2), TFACE+.02]);
        }
    }
}

// Diagonal slats
module diagonal() {
    difference() {
        cube([TWIDTH, TDEPTH, TFACE]);
        rotate([0, 0, -45]) union() {
            for (i = [-(GRIDGAP/2):GRIDGAP*2:TWIDTH-(GRIDGAP)]) {
                translate([i, TBORDER*0, -.01]) cube([GRIDGAP, TDEPTH*sqrt(2), TFACE+.02]);
                translate([-(i+GRIDGAP), TBORDER*0, -.01]) cube([GRIDGAP, TDEPTH*sqrt(2), TFACE+.02]);
            }
        }
    }
    difference() {
        cube([TWIDTH, TDEPTH, TFACE]);
        translate([TBORDER, TBORDER, -.01]) cube([TWIDTH-(TBORDER*2), TDEPTH-(TBORDER*2), TFACE+.02]);
    }
}

// Mounting base
// The .stl from Frameworks github repository must be in the same directory
// as this file.
// The translate() position was calculated by an uncalibrated Mark I eyeball.
//
// The idea is to take the Framework generated blank tile, trim off the
// face, hollow out the mounting area, and add back supports for the
// mounting tabs. 
//
// These mounts are then added to the top face of the tiles (if selected) making
// the tiles ready for printing.
//
// Alternatively, the tiles and the mounting bases can be printed separately and
// connected with an appropriate glue.
//
module sbase(type=0) {
    difference() {
        translate([-88.6, -127.48, -204.]) 
            import("FRAMEWORK_DESKTOP_BLANK_TILE.stl", convexity=10);
        // Slice off the face of the blank
        translate([0, 0, -1]) cube([29.5, 29.5, 1]);
        if (type != 2) {
            // If not solid base, cut out interior
            translate([2, 2, 0]) cube([24.5, 24.5, 1.5]);
            translate([2, 28.5/2-1.5, 0]) cube([24.5, 3, 2]);
        }
    }
    if (type != 2) {
        // Supports for latches
        translate([9.25, 1, 0]) rotate([0, 0, 45]) cube([.7, 12, 1.5]);
        translate([18.25, 1, 0]) rotate([0, 0, -45]) cube([.7, 12, 1.5]);
        translate([27.6, 18.25, 0]) rotate([0, 0, 45]) cube([.7, 12, 1.5]);
        translate([1, 19.4, 0]) rotate([0, 0, -45]) cube([.7, 12, 1.5]);
    }
    if (type==0) {
        // If full skeleton, add a cross brace under alignment lugs
        translate([28.5/2-.5, 1, 0]) cube([1, 26, 1.5]);
    }
    if (type==1) {
        // If blocking, add a wider brace around the edge
        widthb = (TWIDTH - (CUTOUT * 1)) / 2 * 1 - TBORDER;
        lenb = TDEPTH - (TBORDER*2);
        translate([TBORDER, TBORDER, 0]) {
            difference() {
                cube([lenb, lenb, TFACE+.5]);
                translate([widthb, widthb, 0])
                    cube([lenb-(widthb*2), lenb-(widthb*2), TFACE+.5]);
            }
        }
    }
}

// Sunburst/Star tile
module star() {
    difference() {
        union() {
            difference() {
                cube([TWIDTH, TDEPTH, TFACE]);
                translate([TBORDER, TBORDER, -.01]) 
                    cube([TWIDTH-(TBORDER*2), TDEPTH-(TBORDER*2), TFACE+.02]);
            }
            for (i = [0:360/24:360]) {
                translate([TWIDTH/2, TDEPTH/2, TFACE/2-.01])
                    rotate([0, 0, i]) cube([GRIDGAP, TDEPTH*sqrt(2), TFACE+.02], center=true);
            }
        }
        difference() {
            translate([-20, -20, -.02])
                cube([TWIDTH+40, TDEPTH+40, TFACE+.04]);
            translate([0, 0, -.02]) cube([TWIDTH, TDEPTH, TFACE+.04]);
        }
    }
}

// Crosshatch tile
module crosshatch() {
    straight();
    translate([TWIDTH, 0, 0]) rotate([0, 0, 90]) straight();
}

// Lattice tile
module lattice() {
    diagonal();
    translate([TWIDTH, 0, 0]) rotate([0, 0, 90]) diagonal();
}

// Diamond tile
module diamond() {
    diagonal();
    straight();
}

// Honeycomb tile
include <lib_cutouts.scad>

//radi = 1.0;
//rado = 1.15;
module honeyc() {
    difference() {
        cube([TWIDTH, TDEPTH, TFACE]);
//        for (i = [GRIDGAP:GRIDGAP*2:TWIDTH-(GRIDGAP)]) {
//            translate([i, TBORDER, -.01]) cube([GRIDGAP, TDEPTH-(TBORDER*2), TFACE+.02]);
//        }
        translate([TBORDER, TBORDER, -.01]) linear_extrude(TFACE+.02)
            honeycomb(w=TWIDTH-TBORDER, l=TDEPTH-TBORDER, ri=radi, ro=rado, fn=6);
    }
}

// Large honeycomb plate
module honeycm(wid=3, hgt=2, bases=1) {
    mywid = TWIDTH * wid;
    myhgt = TDEPTH * hgt;
    difference() {
        cube([mywid, myhgt, TFACE]);
        translate([TBORDER, TBORDER, -.01]) {
            linear_extrude(TFACE+.02)
                honeycomb(w=mywid-TBORDER, l=myhgt-TBORDER, ri=radi, ro=rado, fn=6);
        }
    }
    translate([0, 0, TFACE]) difference() {
        cube([mywid, myhgt, TFACE+.65]);
        translate([TBORDER, TBORDER, -.01])
            cube([mywid-(TBORDER*2), myhgt-(TBORDER*2), 2.01]);
    }
    if (bases == 2) {
        for (x=[0:TWIDTH:mywid-1], y=[0:TDEPTH:myhgt-1])
            translate([x, y, TFACE-.15]) sbase(type=bMStyle);
    }
    if (bases == 1) {
        for (x=[0, mywid-TWIDTH], y=[0, myhgt-TDEPTH])
            translate([x, y, TFACE-.15]) sbase(type=bMStyle);
    }
}

// Multi tile blank
// This can be used a blank, but it's main purpose is to be fed
// into the slicer, and then:
// 1. Add a height modifier added for starting at 0mm up to your
//    selected face height (default 1mm).
// 2. Set the modifier top and bottom shell layers set to 0.
// 3. Set the desired sparse infill pattern and density.
//
// This will give a (relatively) unbroken expanse of the selected
// pattern and it is much faster to generate than with OpenSCAD.
//
// Setting bMB_style to "Corners" gives the minimum background
// disturbance.
module blankm(wid=3, hgt=2, bases=1, basex=[0,2,0,2], basey=[0,1,0,1]) {
    mywid = TWIDTH * wid;
    myhgt = TDEPTH * hgt;
    // Build the face with a ridge around the outside.  Provides a bit
    // of rigidity and support so that edges don't buckle. 
    difference() {
        cube([mywid, myhgt, TFACE+1.65]);
        translate([TBORDER, TBORDER, TFACE-.01]) cube([mywid-(TBORDER*2), myhgt-(TBORDER*2), 2.01]);
    }
    if (bases == 2) {
        for (x=[0:TWIDTH:mywid-1], y=[0:TDEPTH:myhgt-1])
            translate([x, y, TFACE-.15]) sbase(type=bMStyle);
    }
    if (bases == 1) {
        for (x=[0, mywid-TWIDTH], y=[0, myhgt-TDEPTH])
            translate([x, y, TFACE-.15]) sbase(type=bMStyle);
    }
    if (bases == 3) {
        assert((len(basex)==len(basey)), "bMB_basex and bMB_basey have different sizes");
        for (i = [0:len(basex)-1]) {
            //echo(basex[i], basey[i]);
            translate([basex[i]*TWIDTH, basey[i]*TDEPTH, TFACE-.15]) sbase(type=bMStyle);
        }
    }
}

//
// Main
//
if (bBlank) {
    translate([TWIDTH*0, TDEPTH*0, 0]) { 
        blank(); 
        if (bMount) translate([0, 0, TFACE-.15]) sbase(type=bMStyle);
    }
}
if (bHorizontal) {
    translate([TWIDTH*1+4, TDEPTH*0, 0]) { 
        straight(); 
        if (bMount) translate([0, 0, TFACE-.15]) sbase(type=bMStyle);
    }
}
if (bDiagonal) {
    translate([TWIDTH*0, TDEPTH*1+4, 0]) { 
        diagonal(); 
        if (bMount) translate([0, 0, TFACE-.15]) sbase(type=bMStyle); 
    }
}
if (bSunburst) {
    translate([TWIDTH*1+4, TDEPTH*1+4, 0]) { 
        star(); 
        if (bMount) translate([0, 0, TFACE-.15]) sbase(type=bMStyle);
    }
}
if (bCrosshatch) {
    translate([TWIDTH*2+8, TDEPTH*0, 0]) { 
        crosshatch(); 
        if (bMount) translate([0, 0, TFACE-.15]) sbase(type=bMStyle);
    }
}
if (bLattice) {
    translate([TWIDTH*2+8, TDEPTH*1+4, 0]) {
        lattice(); 
        if (bMount) translate([0, 0, TFACE-.15]) sbase(type=bMStyle);
    }
}
if (bDiamond) {
    translate([TWIDTH*0, TDEPTH*2+8, 0]) { 
        diamond(); 
        if (bMount) translate([0, 0, TFACE-.15]) sbase(type=bMStyle);
    }
}
if (bHoneycomb) {
    translate([TWIDTH*1+4, TDEPTH*2+8, 0]) {
        honeyc(); 
        if (bMount) translate([0, 0, TFACE-.15]) sbase(type=bMStyle);
    }
}
if (bBase) translate([TWIDTH*2+8, TDEPTH*2+8, 0]) sbase(type=bMStyle);

if (bHoneycombMulti) {
    translate([TWIDTH*3+12, TDEPTH*0, 0]) { 
        honeycm(bHC_w, bHC_h, bases=bHC_mstyle);
    }
}
if (bMBlank) {
    translate([TWIDTH*0, TDEPTH*3+12, 0]) { 
        blankm(bMB_w, bMB_h, bases=bMB_style, basex=bMB_basex, basey=bMB_basey);
    }
}

if (bFaceplate) {
    translate([-(FACEPLATE_WIDTH+4), 0, 0]) { face_plate(); }
}

if (bTest) {
    do_test();
}