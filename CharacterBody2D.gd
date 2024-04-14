extends CharacterBody2D

signal gameover

# Constants
const SPEED = 300.0
const JUMP_VELOCITY = -500.0
const WALL_SLIDE_VELOCITY = 130.0

# Variables
var x = false
var facing = 1
var total_jumps = 2
var jump_count = 0

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
	
	# Handle jump
	if Input.is_action_just_pressed("jump") and jump_count < total_jumps:
		velocity.y = JUMP_VELOCITY
		jump_count += 1
		
		var sound_effect = load("res://sound effects/jump.wav")
		sound_player.stream = sound_effect
		sound_player.play()
	
	# Handle dash (shift action)
	if Input.is_action_just_pressed("shift"):
		velocity = Vector2(facing * 720, -800)
		x = true
	
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
	if is_on_ceiling():
		emit_signal("gameover")
