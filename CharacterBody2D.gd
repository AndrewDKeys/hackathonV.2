extends CharacterBody2D

# Get the gravity from the project settings to be synced with RigidBody 
const SPEED = 300.0
const JUMP_VELOCITY = -500.0
const WALL_SLIDE_VELOCITY = 130;

var x = false;
var facing = 1;
var total_jumps = 2;
var jump_count = 0;

func _physics_process(delta):
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
		
	# Get the input direction and handle the movement/deceleration
	
	x = useItem()
	
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		facing = direction;
		velocity.x = direction * SPEED
	elif not x:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	move_and_slide()
	
func useItem() -> bool:
	var x = false
	
	if Input.is_action_just_pressed("shift"):
		velocity = Vector2(facing * 720, -800)
		x = true
		
	return x
