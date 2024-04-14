extends Node2D

var score

# Called when the node enters the scene tree for the first time.
func _ready():
	score = 0
	$SCORE.text = "FYCCJKAJSCH"
	print($Score.text)
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func update_score(i) -> void:
	score += i
	print(score)
