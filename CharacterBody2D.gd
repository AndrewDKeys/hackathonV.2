extends CharacterBody2D

# Get the gravity from the project settings to be synced with RigidBody 
const SPEED = 300.0
const JUMP_VELOCITY = -500.0
const WALL_SLIDE_VELOCITY = 130;

var facing = 1;
var total_jumps = 2;
var jump_count = 0;

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += (1580) * delta
	else:
		jump_count = 0
		
	# Handle jump.
	if Input.is_action_just_pressed("jump") and jump_count < total_jumps:
		velocity.y = JUMP_VELOCITY
		jump_count += 1
		
	# Get the input direction and handle the movement/deceleration.
	useItem()
	
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		facing = direction;
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
func useItem():
	if Input.is_action_just_pressed("shift"):
		velocity = Vector2( facing * 720, -800)
