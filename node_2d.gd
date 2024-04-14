extends Node2D

var game = preload("res://Scenes/Game.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func create_game():
	var thisgame = game.instantiate()
	add_child(thisgame)
	
	thisgame.get_node("Player").connect("gameover", handle_gameover) 	
	
func handle_Mainmenu() -> void:
	$Main.queue_free()
	create_game()
	
func handle_gameover() -> void:
	get_tree().paused = true
	print("DEAD")


func _on_button_pressed():
	handle_Mainmenu()
