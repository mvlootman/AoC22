module main

struct MyStruct {
	score  int
	status string
}

fn main() {
	// x := MyStruct{score: }
	do(MyStruct{})
	// do(score: 12)
	x := MyStruct{}
}

fn do(x MyStruct) {
	println(x)
}
