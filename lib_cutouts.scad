module myBreadboard(w, l, ro, ri) {
	//echo(w, l, ro, ri);
	cols = floor((w - ((ro - ri) * 2)) / 2 / ro) - 1;
	rows = floor((l - ((ro - ri) * 2)) / 2 / ro) - 1;
	offx = floor((w - (cols * 2 * ro)) / 2);
	offy = floor((l - (rows * 2 * ro)) / 2);
	//echo (cols, rows);
	for (col = [0:cols]) {
		for (row = [0:rows]) {
			translate([2 * ro * col + offx, 2 * ro * row + offy, 0]) {
				circle(ri);  
			}
		}
	}
}

module myLattice(w, l, ro, ri) {
	//echo(w, l, ro, ri);
	cols = floor((w - ((ro - ri) * 2)) / ro) - 2;
	rows = floor((l - ((ro - ri) * 2)) / 2 / ro) - 1;
	offx = floor((w - (cols * ro)) / 2);
	offy = floor((l - (rows * 2 * ro)) / 2);
	//echo (cols, rows);
	for (col = [0:cols]) {
		if (col / 2 == floor(col/2)) {
			for (row = [0:rows]) {
				translate([ro * col + offx, 2 * ro * row + offy, 0]) {
					circle(ri, $fn=4);  
				}
			}
		} else {
			for (row = [0:rows-1]) {
				translate([ro * col + offx, 2 * ro * row + offy + ro, 0]) {
					circle(ri, $fn=4);  
				}
			}
		}
	}
}

module honeycomb(w, l, ro, ri, fn) {
	//echo(w, l, ro, ri);
	cols = floor((w - ((ro - ri) * 2)) / 1.75 / ro) - 1;
	rows = floor((l - ((ro - ri) * 2)) / 2 / ro) - 1;
	offx = floor((w - (cols * 1.75 * ro)) / 2);	
	offy = floor((l - (rows * 2 * ro)) / 2);
	//echo (cols, rows);
	for (col = [0:cols]) {
		if (col / 2 == floor(col/2)) {
			for (row = [0:rows]) {
				translate([1.75 * ro * col + offx, 2 * ro * row + offy, 0]) {
					circle(ri, $fn=fn);  
				}
			}
		} else {
			for (row = [0:rows-1]) {
				translate([1.75 * ro * col + offx, 2 * ro * row + offy + ro, 0]) {
					circle(ri, $fn=fn);  
				}
			}
		}
	}
}

module myHeart(w, l, ro, ri) {
	translate([w/2, l/2-ri, 0]){
		rotate([0, 0, 45]){
			translate([0, 0, 0]){
				square(2*ri);
			}
			translate([ri, 0, 0]){
				circle(ri);
			}
			translate([0, ri, 0]){
				circle(ri);
			}
		}
	}
}

module myPlane(w, l, t, ro, ri) {
	wbf = 100+(2*0.8);
	lbf = 100-(2*18.2);
	tbf = 100-(2*46.8);
	scalebf = 2*ri/wbf;
	difference() {
		linear_extrude(t) {
			difference() {
				square([w, l]);
				//myBreadboard(w, l, ro, ri);
				//myLattice(w, l, ro, ri);
				//myHoneycomb(w, l, ro, ri);
				//myHeart(w, l, ro, ri);
			}
		}
		translate([w-((w-(wbf*scalebf))/2), l-((l-(lbf*scalebf))/2), 1]) {
			rotate([0, 0, 180]) { 
				scale(scalebf){
					import("C:\\BTSync\\Paul\\Projects\\printrbot simple\\Documents\\STL Files\\butterfly.STL");
				}
			}
		}
	} 
}
