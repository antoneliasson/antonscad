/*
 * A library of transformations and operations on objects.
 *
 * Copyright (c) 2017 Anton Eliasson
 *
 * MIT License
 */

/*
 * Alias for linear_extrude, without the need to name the height parameter.
 */
module linextr(h, center=false) {
	linear_extrude(height=h, center=center) children();
}

/*
 * Mirror children through the XZ plane, the YZ plane, and both, resulting in
 * four copies around the origin.
 */
module fourwaymirror() {
	children();
	mirror([1, 0, 0]) children();
	mirror([0, 1, 0]) children();
	mirror([1, 0, 0]) mirror([0, 1, 0]) children();
}

module mirrorXZ() {
    children();
    mirror([0, 1, 0]) children();
}

module mirrorYZ() {
	children();
	mirror([1, 0, 0]) children();
}

// TODO fourwaymirror = mirrorXZ mirrorYZ
