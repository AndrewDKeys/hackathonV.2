extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.connect("gameover", handle_gameover);
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func handle_gameover() -> void:
	get_tree().paused = true
	print("DEAD")
