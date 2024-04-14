extends CharacterBody2D

signal gameover

# Get the gravity from the project settings to be synced with RigidBody 
const SPEED = 300.0
const JUMP_VELOCITY = -500.0
const WALL_SLIDE_VELOCITY = 130;

var x = false;
var facing = 1;
var total_jumps = 2;
var jump_count = 0;

var sound_player = AudioStreamPlayer.new()
var bg_music := AudioStreamPlayer.new()


func _ready(): 
	sound_player.bus = "Player SFX"
	add_child(sound_player) 
	
	#bg_music.stream = load("res://hackathon in progress.ogg")
	#bg_music.autoplay = true
	#add_child(bg_music)

func _physics_process(delta):
	isDead()
	# Add the gravity.
	if not is_on_floor():
		velocity.y += (1580) * delta
	else:
		x = false
		jump_count = 0
		
	# Handle jump.
	if Input.is_action_just_pressed("jump") and jump_count < total_jumps:
		velocity.y = JUMP_VELOCITY
		jump_count += 1
		
		var sound_effect = load("res://sound effects/jump.wav")
		sound_player.stream = sound_effect
		sound_player.play()
		
	# Get the input direction and handle the movement/deceleration
	if Input.is_action_just_pressed("shift"):
		velocity = Vector2(facing * 720, -800)
		x = true

	
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		facing = direction;
		velocity.x = direction * SPEED
	elif not x:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
		
	#Determines when the player hits the ground
	var was_in_air: bool = not is_on_floor()
	
	move_and_slide()
		
	var just_landed: bool = is_on_floor() and was_in_air
	  
	if just_landed:
		var sound_effect = load("res://sound effects/landing.wav")
		sound_player.stream = sound_effect
		sound_player.play()    
		
	
func isDead():
	if is_on_ceiling():
		emit_signal("gameover")
