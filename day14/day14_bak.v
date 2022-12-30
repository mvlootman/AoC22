// import strings
// // import arrays
//
// const (
// 	air           = `.`
// 	rock          = `#`
// 	sand          = `o`
// 	drop_location = `+`
// )
//
// struct Coord {
// mut:
// 	x int
// 	y int
// }
//
// fn main() {
// 	input := '498,4 -> 498,6 -> 496,6\n503,4 -> 502,4 -> 502,9 -> 494,9'
// 	paths := input.split('\n').map(it.split(' -> ')).map(parse_coord(it))
// 	// println(paths)
// 	min_x, max_x, min_y, max_y := find_min_max(paths)
// 	println('min_x:${min_x} max_x:${max_x} min_y:${min_y} max_y:${max_y}')
//
// 	width := max_x - min_x + 1
// 	height := max_y + 1
// 	println('grid should be of height:${height} width:${width}')
// 	mut grid := [][]rune{len: height, init: []rune{len: width, init: air}}
// 	// add paths
// 	for path in paths {
// 		for idx, coord in path {
// 			if idx < path.len - 1 {
// 				next_coord := path[idx + 1]
//
// 				if coord.x == next_coord.x {
// 					// range over y
// 					if coord.y > next_coord.y {
// 						for dy in 1 .. coord.y + 1 - next_coord.y {
// 							grid[coord.y - dy][coord.x - min_x] = rock
// 						}
// 					} else {
// 						for dy in 1 .. next_coord.y + 1 - coord.y {
// 							grid[coord.y + dy][coord.x - min_x] = rock
// 						}
// 					}
// 				} else {
// 					// range over x
// 					if coord.x > next_coord.x {
// 						for dx in 1 .. coord.x + 1 - next_coord.x {
// 							grid[coord.y][coord.x - dx - min_x] = rock
// 						}
// 					} else {
// 						for dx in 1 .. next_coord.x + 1 - coord.x {
// 							grid[coord.y][coord.x + dx - min_x] = rock
// 						}
// 					}
// 				}
// 			}
// 			grid[coord.y][coord.x - min_x] = rock
// 		}
// 	}
// 	print_grid(grid, min_x, max_x)
//
// 	drop_sand(mut grid, min_x, max_y, max_x)
// 	print_grid(grid, min_x, max_x)
// }
//
// // drop_sand updates the grid one iteration
//
// fn drop_sand(mut grid [][]rune, min_x int, max_y int, max_x int) {
// 	// while not stable next
// 	drop_loc := Coord{500, 0}
// 	grid[0][drop_loc.x - min_x] = drop_location
//
// 	sand_coord := calc_sand_loc(drop_loc, grid, min_x, max_y) or {
// 		// no sand location possible
// 		println('no sand location possible from:${drop_loc}')
// 		return
// 	}
// 	println('sand_coord:${sand_coord}')
// 	grid[sand_coord.y][sand_coord.x - max_x] = sand
// 	print_grid(grid, min_x, max_x)
// }
//
// fn calc_sand_loc(drop_location Coord, grid [][]rune, min_x int, max_y int) !Coord {
// 	mut curr_pos := drop_location
// 	// sand falls down
// 	for {
// 		curr_pos.y += 1
// 		if grid[curr_pos.y][curr_pos.x - min_x] == air && curr_pos.y <= max_y {
// 			continue
// 		}
// 		// we can't go any further (either we hit a rock or fall off the map)
// 		return Coord{curr_pos.x - min_x, curr_pos.y - 1}
// 	}
// 	return Coord{}
// }
//
// fn print_grid(grid [][]rune, start_x int, end_x int) {
// 	// print xs as three digits downwards as header
// 	pad_left := 2
// 	mut header := ''
// 	for pos in 0 .. 3 {
// 		header += strings.repeat(` `, pad_left)
// 		for n in start_x .. end_x + 1 {
// 			header += n.str()[pos].ascii_str()
// 		}
// 		header += '\n'
// 	}
// 	println(header.trim_right(' \n'))
//
// 	for idx, row in grid {
// 		print('${idx} ')
// 		for cell in row {
// 			print(cell.str())
// 		}
// 		print('\n')
// 	}
// 	println('')
// }
//
// fn parse_coord(point_str []string) []Coord {
// 	mut coords := []Coord{}
//
// 	return point_str.map(it.split(',')
// 		.map(it.int()))
// 		.map(Coord{it[0], it[1]})
// }
//
// fn find_min_max(paths [][]Coord) (int, int, int, int) {
// 	first := paths[0][0]
// 	mut min_x := first.x
// 	mut max_x := first.x
// 	mut min_y := first.y
// 	mut max_y := first.y
//
// 	for path in paths {
// 		for coord in path {
// 			if coord.x < min_x {
// 				min_x = coord.x
// 			}
// 			if coord.x > max_x {
// 				max_x = coord.x
// 			}
// 			if coord.y < min_y {
// 				min_y = coord.y
// 			}
// 			if coord.y > max_y {
// 				max_y = coord.y
// 			}
// 		}
// 	}
// 	return min_x, max_x, min_y, max_y
// }
