extends Node2D
signal pick_me
var item_type

# Called when the node enters the scene tree for the first time.
func _ready():
	item_type = "fc"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_2d_body_entered(body):
	if body is CharacterBody2D:
		emit_signal("pick_me", self)
	pass
