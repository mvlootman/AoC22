module main

import arrays

fn main() {
	mut score_map := {
		1: 100
		2: 120
		3: 14
	}

	arr_keys := score_map.keys()
	arr_values := score_map.values()
	b := arrays.group[int](arr_keys, arr_values)
	println(typeof(b)) // [][]int

}
