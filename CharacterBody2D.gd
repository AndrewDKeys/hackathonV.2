extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
# Reference to the AnimationTree node in your scene
@onready var animation_tree = $AnimationTree

func _physics_process(delta):
	# Add gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Handle jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Get the input direction and handle movement
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		# Update velocity based on input
		velocity.x = direction * SPEED
		# Set the blend position for the 'walk' BlendSpace1D based on direction
		animation_tree.set("parameters/walk/blend_position", direction)
	else:
		# Decelerate velocity towards zero
		velocity.x = move_toward(velocity.x, 0, SPEED * delta)
		# Set the blend position to 0 for idle animation
		animation_tree.set("parameters/idle/blend_position", 0)
	
	# Handle movement
	move_and_slide()
