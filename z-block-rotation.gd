extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	var rand = randi() % 4
	match rand:
		0:
			rotation_degrees = 0
		1:
			rotation_degrees = 90
		2:
			rotation_degrees = 180
		3:
			rotation_degrees = 270
