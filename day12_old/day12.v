module main

import os

struct Coord {
	x int
	y int
}

fn (c Coord) str() string {
	return '(${c.x},${c.y})'
}

fn main() {
	lines := os.read_lines('./day12/day12_sample
	.txt')!
	width, height := lines.first().len, lines.len

	mut grid := [][]rune{len: height, init: []rune{len: width}} // no intellisense for len/cap/init

	for idx, l in lines {
		grid[idx] = l.runes()
	}
	start_pos := find_location(grid, `S`)
	grid[start_pos.y][start_pos.x] = `a` // start S -> elevation `a`
	end_pos := find_location(grid, `E`)
	// mut seen := map[string]bool{} // would like map[Coord]bool or map[(x,y)]bool
	println('grid width: ${width} height:${height}')
	// print_grid(grid)
	println('start_pos:${start_pos} end_pos:${end_pos}')
	mut current_pos := start_pos
	// seen[current_pos.str()] = true
	// mut paths := [][]Coord{}
	mut path := []string{} //['${start_pos.x},${start_pos.y}']

	mut path_lens := []int{}
	// for y, row in grid {
	// 	for x, col in row {

	for nav in [[0, 1], [1, 0], [0, -1], [-1, 0]] {
		mut seen := map[string]bool{} // would like map[Coord]bool or map[(x,y)]bool
		seen[start_pos.str()] = true
		paths := visit_adjacent(start_pos.y + nav[1], start_pos.x + nav[0], grid, mut
			seen, mut path)
		println('===>return =${paths} path:${path}')

		for c in path {
			xx := c.split(',')[0].int()
			yy := c.split(',')[1].int()
			print('${grid[yy][xx]}-')
		}
	}
	println('')
	// }
	// }
	// println('visited:${seen}')
	// println('path:${path}')
	println('paths-lens ${path_lens}}') // includes the first step so answer = len-1
}

fn visit_adjacent(y int, x int, grid [][]rune, mut seen map[string]bool, mut path []string) []string {
	println('visiting x,y ${x},${y}')
	width, height := grid[0].len, grid.len // optimize
	if y < 0 || y > height - 1 || x < 0 || x > width - 1 {
		return path
	}
	current_val := grid[y][x]
	if current_val == `E` {
		println('--------->found exit! len=${path.len} }PATH:${path}}')
		return path
	}
	navigations := [[0, 1], [1, 0], [0, -1], [-1, 0]] // down/right/up/left

	for idx, nav in navigations {
		println('idx=${idx} and nav=${nav} nav.x=${nav[0]} nav.y=${nav[1]}}}')
		candidate_x := x + nav[0]
		candidate_y := y + nav[1]
		println('candidate coords: ${candidate_x},${candidate_y}')
		if '${candidate_x},${candidate_y}' in seen {
			println('already seen: ${candidate_x},${candidate_y}')
			continue
		}
		if candidate_x >= 0 && candidate_x < width && candidate_y >= 0 && candidate_y < height {
			println('x,y:${x},${y} and candidate_x,y:${candidate_x},${candidate_y} val:${grid[candidate_y][candidate_x]}}')
			candidate_val := grid[candidate_y][candidate_x]
			if current_val + 1 >= candidate_val {
				println('found a valid move ${candidate_x},${candidate_y}')
				path << '${candidate_x},${candidate_y}'
				seen['${candidate_x},${candidate_y}'] = true

				return visit_adjacent(candidate_y, candidate_x, grid, mut seen, mut path)
			}
		} else {
			println(' out of bounds:${candidate_x},${candidate_y} ')
		}
	}
	// path = []string{} // not valid path
	return path
}

fn print_grid(grid [][]rune) {
	for row in grid {
		println(row)
	}
}

fn find_location(grid [][]rune, target rune) Coord {
	for r_id, row in grid {
		for c_id, col in row {
			// println('col:${col} r_id:${r_id}, row:${row} target:${target}')
			if col == target {
				return Coord{c_id, r_id}
			}
		}
	}
	panic('target ${target} was not found in grid}')
}
