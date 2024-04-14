extends Node2D

var score

# Called when the node enters the scene tree for the first time.
func _ready():
	score = 0
	$Score.text = "SCORE: " + str(score)

	get_parent().get_node("Timer").connect("score_update", update_score)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func update_score(i) -> void:
	score += i
	$Score.text = "SCORE: " + str(score)
	print(score)
