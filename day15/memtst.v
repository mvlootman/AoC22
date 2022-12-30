struct Point {
	x int
	y int
}

fn (p Point) str() string {
	return '${p.x},${p.y}'
}

fn main() {
}

fn all_points() []Point {
	return []Point{}
}

/*
list of areas of sensors + beacons location
*/
