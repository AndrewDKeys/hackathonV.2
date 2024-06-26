extends CharacterBody2D

signal gameover
signal give_items



# Constants
const SPEED = 300.0
const JUMP_VELOCITY = -500.0
const WALL_SLIDE_VELOCITY = 130.0

var items_on_screen = []
var my_items = []

# Variables
var x = false
var facing = 1
var total_jumps = 2
var jump_count = 0

var first = true
var last_floor
var last_head

# Audio players
var sound_player = AudioStreamPlayer.new()
var bg_music = AudioStreamPlayer.new()

# Reference to the AnimationTree node
@onready var animation_tree = $AnimationTree

# Ready function to set up audio players
func _ready():
	sound_player.bus = "Player SFX"
	add_child(sound_player)
	
	bg_music.stream = load("res://hackathonBGM.ogg")
	bg_music.autoplay = true
	add_child(bg_music)
	
	get_parent().get_node("PowerUpTimer").connect("items_list", init_list)

func init_list(item) -> void:
	if item != null:
		item.connect("pick_me", do_item)
		items_on_screen.append(item)

func list_logic(type):
	if not my_items.size() >= 2:
		if type == "jump3" and total_jumps < 5:
			total_jumps +=1
		else:
			my_items.append(type)
			emit_signal("give_items", my_items)	

func do_item(item) -> void:
	var y = 0
	for i in items_on_screen:
		if i == item:
			list_logic(item.item_type)
			item.queue_free()
			items_on_screen.remove_at(y)
		y += 1
		
# Physics process function for movement and actions
func _physics_process(delta):
	# Check for game over state
	isDead()
	
	# Add gravity
	if not is_on_floor():
		velocity.y += 1580 * delta
	else:
		x = false
		jump_count = 0
		
	#its so bad pls love us mr ibm
	if Input.is_action_pressed("shift") and my_items.size() > 0:		
		match my_items.pop_at(0):
			"fc":
				get_parent().get_node("Timer").refactor()	
			"bomb":
				pass
			"bubble":
				pass
			"slingshot":
				velocity = Vector2(facing * 600, -800)
				x = true
	emit_signal("give_items", my_items)		#AWFUL CODE BUT WE HAVE NO TIMME!!!!!!!
	
	# Handle jump
	if Input.is_action_just_pressed("jump") and jump_count < total_jumps:
		velocity.y = JUMP_VELOCITY
		jump_count += 1
		
		var sound_effect = load("res://sound effects/jump.wav")
		sound_player.stream = sound_effect
		sound_player.play()
	
	# Get the input direction and handle movement
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		facing = direction
		velocity.x = direction * SPEED
		# Set the blend position for the walk BlendSpace1D based on the facing direction
		animation_tree.set("parameters/walk/blend_position", facing)
	elif not x:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	#Don't move this it has to stay here to work
	var was_in_air = not is_on_floor()
	
	# Move and slide
	move_and_slide()
	
	# Play landing sound effect
	if is_on_floor() and was_in_air:
		var sound_effect = load("res://sound effects/landing.wav")
		sound_player.stream = sound_effect
		sound_player.play()	

# Function to check if the character is dead
func isDead():
	if first:
		first = false
	else:
		if last_floor and is_on_ceiling():
			emit_signal("gameover")
		if is_on_floor() and is_on_ceiling():
			emit_signal("gameover")
		if is_on_floor() and last_head:
			emit_signal("gameover")
		
	last_head = is_on_ceiling()	
	last_floor = is_on_floor()

func _on_area_2d_body_entered(body):
	last_head = true
