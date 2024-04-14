extends Node2D

const game = preload("res://Scenes/Game.tscn")
var gameInstance

# Called when the node enters the scene tree for the first time.
func _ready():
	$EndMenu.visible = false
	#await get_tree().create_timer(1.2).timeout 
	$Logo.hide()
	
	pass

func create_game():
	gameInstance = game.instantiate()
	add_child(gameInstance)
	gameInstance.get_node("Player").connect("gameover", handle_gameover) 	
	
func handle_Mainmenu(MenuType) -> void:
	$Main.visible = false
	create_game()
	
func handle_gameover() -> void:
	get_tree().paused = true
	gameInstance.queue_free()
	$EndMenu.visible = true
	get_tree().paused = false

func _on_button_pressed():
	handle_Mainmenu($Main)

func _on_endMenu_pressed():
	$EndMenu.visible = false
	create_game()
