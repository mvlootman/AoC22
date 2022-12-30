/*
sample route:
[AA] -> DD* -> CC -> BB -> AA -> II -> JJ*, II, AA, DD, EE, FF, GG, HH*, GG, FF, EE, DD, CC*, <no_move*6>,

DD_3, BB_5, JJ_9, HH_17, CC_24
<node_opening minute>
*/

module main

import os
import regex
import datatypes
import arrays { sum }
import math

struct Valve {
	node        string
	rate        int
	connections []string
mut:
	possible_nodes map[string]int
}

struct State {
mut:
	node          string
	time          int
	total_flow    int
	opened_valves []string
}

struct Volcano {
mut:
	lookup map[string]Valve
}

fn main() {
	mut volcano := Volcano{}
	valves := parse_input('day16.txt')!

	volcano.add_valves(valves)
	volcano.compute_distance_per_node()
	part1 := volcano.visit(valves.first())!
	println('Part 1: ${part1}\nPart2: not implemented, someday maybe...')
}

fn (mut v Volcano) compute_distance_per_node() {
	for k, _ in v.lookup {
		step_map := v.cost_map(k) or { panic(err) }
		v.lookup[k].possible_nodes = step_map.clone()
	}
}

fn (mut v Volcano) add_valves(valves []Valve) {
	for valve in valves {
		v.lookup[valve.node] = valve
	}
}

fn (v Volcano) sum_opened_valves(open_valves []string) int {
	mut sum := 0
	for val in open_valves {
		sum += v.lookup[val].rate
	}
	return sum // sum(open_valves.map(v.lookup[it].rate)) or { 0 }
}

// fn (v Volcano) calc_curr_score(curr_flow int, curr_time int, opened_valves []string) int {
// 	return curr_flow + (curr_time * v.sum_opened_valves(opened_valves))
// }

[inline]
fn (v Volcano) visit(valve Valve) !int {
	start := valve.node
	mut q := datatypes.Queue[State]{}
	q.len()
	q.push(State{
		node: start
		time: 30
		total_flow: 0
		opened_valves: []string{}
	})
	mut max_q_len := 1
	mut best := math.min_i32
	for q.len() > 0 {
		curr := q.pop()!

		candidates := v.lookup.values().filter(it.rate > 0 && curr.node != it.node
			&& it.node !in curr.opened_valves)

		if candidates.len == 0 {
			score := curr.total_flow + curr.time * v.sum_opened_valves(curr.opened_valves)
			if score > best {
				best = score
			}
		}

		for candidate in candidates {
			// this is a non-opened valve, with a rate > 0
			// from current node to candidate, we know the amount of steps to take from the pre-computed map
			steps := v.lookup[curr.node].possible_nodes[candidate.node] + 1 // steps + 1 (open valve)

			if steps > curr.time {
				// we hit an ending condition (out of time to complete)
				score := curr.total_flow + curr.time * v.sum_opened_valves(curr.opened_valves)
				if score > best {
					best = score
				}
			} else {
				q.push(State{
					node: candidate.node
					time: curr.time - steps
					total_flow: curr.total_flow + steps * v.sum_opened_valves(curr.opened_valves)
					opened_valves: arrays.concat(curr.opened_valves, candidate.node)
				})
				max_q_len++
			}
		}
	}
	// println('solution size:${solutions.len}') //:2328952 puzzle input
	println('max q-len:${max_q_len}')
	return best
}

fn (v Volcano) cost_map(start_node string) !map[string]int {
	// BFS to calculate the amount of steps needed to reach each node
	mut queue := datatypes.Queue[string]{}
	mut cost_map := map[string]int{}

	cost_map[start_node] = 0
	queue.push(start_node)

	for queue.len() > 0 {
		curr := queue.pop()!
		for adj in v.lookup[curr].connections {
			if adj !in cost_map {
				cost_map[adj] = cost_map[curr] + 1
				queue.push(adj)
			}
		}
	}
	return cost_map
}

fn parse_input(file string) ![]Valve {
	input_pattern := r'Valve (\w+) has flow rate=(\d+); tunnels? leads? to valves? (.*)'
	regex := regex.regex_opt(input_pattern) or { panic(err) }
	valves := os.read_lines(file)!
		.map(parse_valve(it, regex))

	return valves
}

fn parse_valve(line string, regex regex.RE) Valve {
	// example: Valve AA has flow rate=0; tunnels lead to valves DD, II, BB
	regex.match_string(line)
	matches := regex.get_group_list()
		.map(line[it.start..it.end])

	return Valve{
		node: matches[0]
		rate: matches[1].int()
		connections: matches[2].split(',').map(it.trim_space())
	}
}
