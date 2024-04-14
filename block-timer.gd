extends Timer

const DROP_HEIGHT = -50

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

func _ready():
	wait_time = 1

func _on_timeout():
	randomize()
	var block_list = [single, cross, left_l, right_l, s_block, z_block, line_block, cage_block, t_block, square_block]
	var dropped = block_list[randi() % block_list.size()]
	var block = dropped.instantiate()
	block.set_global_position(Vector2(randf_range(300, 860), DROP_HEIGHT))
	add_child(block)
