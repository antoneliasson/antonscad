/*
 * A library of (at the moment) 2D shapes.
 *
 * Copyright (c) 2017 Anton Eliasson
 *
 * MIT License
 */

/*
 * Rounded rectangle (1 corner)
 *
 * Right angle in origin, rounded corner furthest from origin.
 */
module rrect1(x, y, r) {
	assert(x >= 2*r && y >= 2*r);

	hull () {
		polygon([[0, 0], [x, 0], [0, y]]);
		translate([x-r, y-r, 0]) circle(r=r);
	}
}

/*
 * Rounded square (1 corner)
 *
 * Like rrect1 but equilateral.
 */
module rsquare1(s, r) {
	rrect1(s, s, r);
}

/*
 * Rounded rectangle (all 4 corners)
 */
module rrect4(x, y, r) {
	offset(r=r) offset(delta=-r) square([x, y], true);
}

/*
 * Rounded square (all 4 corners)
 *
 * Like rrect4 but equilateral.
 */
module rsquare4(s, r) {
	rrect4(s, s, r);
}

/*
 * Triangle with right angle in origin.
 */
module triangle(x, y) {
	polygon([[0, 0], [x, 0], [0, y]]);
}
