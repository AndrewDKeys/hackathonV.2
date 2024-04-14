extends Node2D

var map = {
	"bubble": "res://hackathon sprites/bubble.png",
	"bomb": "res://hackathon sprites/bomb.png" ,
	"fc": "res://hackathon sprites/full_clear.png" ,
	"slingshot":  "res://hackathon sprites/sling_shot.png",
}

var ItemBlock1
var ItemBlock2

# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().get_node("Player").connect("give_items", set_items)
	pass # Replace with function body.

func set_items(items) -> void:
	
	if items.size() == 2:
		var block1 = $ItemBlock.get_node("TextureRect")
		var block2 = $ItemBlock2.get_node("TextureRect")
		
		block1.visible = true
		block2.visible = true
		
		block1.set_texture(load(map[items[0]]))
		block2.set_texture(load(map[items[1]]))
	elif items.size() == 1:
			var block1 = $ItemBlock.get_node("TextureRect")
			
			block1.visible = true
			block1.set_texture(load(map[items[0]]))
			$ItemBlock2.get_node("TextureRect").visible = false
	else:
		var block1 =  $ItemBlock.get_node("TextureRect")
		var block2 =  $ItemBlock2.get_node("TextureRect")
		
		if block1 != null:
			block1.visible = false
		
		if block2 != null:
			block2.visible = false
	
	
