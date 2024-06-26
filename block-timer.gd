extends Timer

const DROP_HEIGHT = -50

signal score_update

var single = preload("res://blocks/single-block.tscn")
var cross = preload("res://blocks/cross-block.tscn")
var left_l = preload("res://blocks/left-l-block.tscn")
var right_l = preload("res://blocks/right-l-block.tscn")
var s_block = preload("res://blocks/s-block.tscn")
var z_block = preload("res://blocks/z-block.tscn")
var line_block = preload("res://blocks/line-block.tscn")
var cage_block = preload("res://blocks/cage-block.tscn")
var t_block = preload("res://blocks/t-block.tscn")
var square_block = preload("res://blocks/square-block.tscn")

var map = {
	single: 5,
	left_l: 20,
	right_l:20,
	s_block: 10,
	z_block: 10,
	line_block: 25,
	cage_block: 40,
	t_block: 15,
	square_block: 10,
	cross: 66 #6
}

var block_count # Used to help calculate score and rounds
var round_number
var refactoring # boolean that tells us whether or not we are trying to resize
var dropped_list = Array()

# maps round number to blocks needed to proceed
# after round 10, the difficulty will follow a different algorithm
var round_procedure = {
	1 : 5,
	2 : 5,
	3 : 7,
	4 : 7,
	5 : 12,
	6 : 12,
	7 : 16,
	8 : 16,
	9 : 20,
	10 : 20
}

func _ready():
	round_number = 1
	block_count = 0
	wait_time = 2
	refactoring = false

func _on_timeout():
	randomize()
	var chance = randi() % 2
	if dropped_list.size() < 25 && not refactoring:
		drop_block()
	elif chance == 0:
		carpet_bomb()
	elif not refactoring:
		refactor()
	else:
		pass

func drop_block():
	randomize()
	var block_list = [single, cross, left_l, right_l, s_block, z_block, line_block, cage_block, t_block, square_block]
	var dropped = block_list[randi() % block_list.size()]
	var block = dropped.instantiate()
	block.set_global_position(Vector2(randf_range(375, 830), DROP_HEIGHT))
	add_child(block)
	
	dropped_list.append(block)
	update()
	send_score(map[dropped])

func update():
	block_count += 1
	if block_count == round_procedure[round_number]:
		round_number += 1
		if round_number % 2 == 0 && wait_time > 0.25: # on even rounds the wait time will go down
			wait_time -= 0.03 * round_number
		block_count = 0

func send_score(i):
	emit_signal("score_update", i)

func refactor():
	for i in dropped_list:
		i.queue_free()
	dropped_list.clear()
	
func carpet_bomb():
	randomize()
	for i in range(5):
		var tiny = single.instantiate()
		tiny.set_global_position(Vector2(randf_range(375, 830), DROP_HEIGHT))
		add_child(tiny)
		dropped_list.append(tiny)
