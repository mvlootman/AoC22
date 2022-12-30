import regex
import pcre

fn main() {
	inputs := [
		'Valve AA has flow rate=0; tunnels lead to valves DD, II, BB',
		'Valve BB has flow rate=13; tunnels lead to valves CC, AA',
		'Valve CC has flow rate=2; tunnels lead to valves DD, BB',
		'Valve DD has flow rate=20; tunnels lead to valves CC, AA, EE',
		'Valve EE has flow rate=3; tunnels lead to valves FF, DD',
		'Valve FF has flow rate=0; tunnels lead to valves EE, GG',
		'Valve GG has flow rate=0; tunnels lead to valves FF, HH',
		'Valve HH has flow rate=22; tunnel leads to valve GG',
		'Valve II has flow rate=0; tunnels lead to valves AA, JJ',
		'Valve JJ has flow rate=21; tunnel leads to valve II',
	]
	mut r := pcre.new_regex(r'[A-Z][A-Z]|\d+', 0)?

	mut re := regex.regex_opt(r'[A-Z][A-Z]|\d+')?
	for l in inputs {
		println(l)
		res := re.find_all_str(l)
		res2 := re.find_all(l)
		println(res)
		println(res2)

		m := r.match_str(l, 0, 0) or {
			println('No match!')
			return
		}
		println(m.get_all())

		break
	}
}
