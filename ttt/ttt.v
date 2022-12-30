mut arr := []int{len: 2}
println(arr)
arr << 3
println(arr)
// // module main
//
// struct Node {
// mut:
// 	level int
// 	val   []int
// 	child &Node
// }
//
// fn main() {
// 	mut root := &Node{
// 		level: 0
// 		val: [1]
// 		child: &Node{
// 			level: 1
// 			val: [2]
// 			child: &Node{
// 				level: 2
// 				val: [3]
// 				child: &Node{
// 					level: 3
// 					val: [4]
// 					child: &Node{
// 						level: 4
// 						val: [5, 6, 7]
// 					}
// 				}
// 			}
// 		}
// 	}
//
// 	// mut c := root
// 	// for {
// 	// 	println(c)
// 	// 	has_child := !isnil(c.child)
// 	// 	println('level:${c.level} val:${c.val} hasChild:${has_child}')
// 	// 	if has_child {
// 	// 		c = c.child
// 	// 	} else {
// 	// 		println('end of the line')
// 	// 		break
// 	// 	}
// 	// }
// 	// println('[1,[2,[3,[4,[5,6,7]]]],8,9]'.split('['))
// 	// input := '[1,[2,[3,[4,[5,6,7]]]],8,9]'
// 	input := '[1,2,[3]]'
//
// 	mut level := -1
// 	mut num := ''
// 	mut curr := Node{
// 		level: 0
// 		val: []int{}
// 	}
//
// 	for c in input {
// 		println('peek-c:${c.ascii_str()} cur:${curr}')
// 		match c {
// 			`[` {
// 				println('found `[` num=${num}')
// 				if num.len > 0 {
// 					// finish prev expr
// 					curr.val << num.int()
// 					num = ''
// 				}
//
// 				level++
//
// 				curr.child = &Node{
// 					level: level
// 					val: []int{}
// 				}
//
// 				println('curr1:${curr}}')
// 				println('curr2:${curr}}')
// 			}
// 			`]` {
// 				if num.len > 0 {
// 					curr.val << num.int()
// 					num = ''
// 				}
// 				level--
// 			}
// 			`,` {
// 				curr.val << num.int()
// 				num = ''
// 			}
// 			else {
// 				num += c.ascii_str()
// 			}
// 		}
// 	}
// 	println('after =>${curr}')
// }
