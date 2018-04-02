/*
 * 3D block shapes.
 *
 * Copyright (c) 2018 Anton Eliasson
 *
 * MIT License
 */
include <MCAD/units.scad>

use <se/antoneliasson/operations.scad>
use <se/antoneliasson/2d/shapes.scad>

/**
 * Rounded rectangular cuboid with chamfered edges on the bottom side
 *
 * Primarily intended as an enclosure floor.
 *
 * @param w width (X)
 * @param l length (Y)
 * @param h height/thickness (Z)
 * @param r corner radius
 */
module chamfered_rounded_cuboid(w, l, h, r) {
	assert(r >= h);
	hull() {
		fourwaymirror() {
			translate([w/2-r, l/2-r, 0]) {
				cylinder(h=h, r1=r-h, r2=r);
			}
		}
	}
}

/**
 * Screw hole standoff feature for enclosure_rounded
 *
 * The actual hole radius is r+tol. While r is used to calculate the
 * size of each standoff, tol does not offset it.
 *
 * @param r hole radius
 * @param tol hole radius tolerance
 */
module with_screw_holes(r, tol) {
	fourwaymirror() {
		translate([0, 0, $wt]) {
			_enclosure_corner($w-2*$wt, $l-2*$wt, $h-$wt, r, tol);
			//translate([w/2, ])
		}
	}

}

/**
 *
 * @param w enclosure inner width (X)
 * @param l enclosure inner length (Y)
 * @param h enclosure inner height (Z)
 * @param r
 * @param tol
 */
module _enclosure_corner(w, l, h, r, tol) {
	difference () {
		translate([w/2, l/2, 0]) {
			rotate(180) {
				linear_extrude(height=h) {
					rsquare1(4*r, 3);
				}
			}
		}
		translate([w/2-2*r, l/2-2*r, 0]) {
			cylinder(h=h, r=r+tol);
		}
	}
}

/**
 * Hook shaped snaps feature for enclosure_rounded
 *
 * Places n equidistant hooks on each long side (Y) of the enclosure.
 *
 * @param n number of hooks per side
 * @param hl hook length (Y)
 * @param hh hook heigh (Z)
 * @param tol tolerance to add to each dimension. This is the total
 *            tolerance, not the tolerance of each face.
 */
module with_hooks(n, hl, hh, tol=0) {
	mirrorYZ() {
		translate([$w/2, -$l/2, $h]) {
			for (i = [1:n]) {
				translate([0, $l*i/(n+1), 0]) {
					_enclosure_hook($wt/2, hl, hh, tol);
				}
			}
		}
	}
}

/**
 *
 * @param t thickness in both X and Z dimensions
 * @param w hook width (Y)
 * @param h hook total height (Z)
 * @param tol tolerance to add to each dimension
 */
module _enclosure_hook(t, w, h, tol=0) {
	translate([-t-t/2-tol/2, 0, 0]) {
		rotate(90*X) {
			linextr(w+tol, true) {
				difference() {
					square([t+t/2+tol+epsilon, h+epsilon]);
					trapezoid(t/4, 3*t/4, h-t-tol, 0);
				}
			}
		}
	}
}

/**
 * Open enclosure shape, with rounded walls and a chamfered floor
 *
 * TODO: numerical stability wrt floor vs walls. Use extruded difference of hulls of circles instad of rrect4?
 * $fn=$fn as parameter?
 *
 * @param w width (X)
 * @param l length (Y)
 * @param h height (Z)
 * @param wt wall thickness
 * @param r corner radius
 */
module enclosure_rounded(w, l, h, wt, r) {
	// floor
	chamfered_rounded_cuboid(w, l, wt, r);

	// walls
	translate([0, 0, wt]) {
		linextr(h-wt) {
			difference() {
				rrect4(w, l, r);
				offset(delta=-wt) rrect4(w, l, r);
			}
		}
	}

	// export attributes for optional features which are called as children()
	$w=w;
	$l=l;
	$h=h;
	$wt=wt;
	children();
}
//$fn=3;
//# render() enclosure_rounded(40, 80, 12, 5, 5) with_screw_holes(2.5, 0.15);
enclosure_rounded(40, 80, 12, 2, 5) with_hooks(3, 8, 4);
