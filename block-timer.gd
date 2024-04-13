extends Timer

const DROP_HEIGHT = -50

var single = preload("res://single-block.tscn")

func _on_timeout():
	randomize()
	var block_list = [single]
	var dropped = block_list[0]
	var block = dropped.instantiate()
	block.set_global_position(Vector2(randf_range(300, 860), DROP_HEIGHT))
	add_child(block)
