extends RigidBody2D

const HORIZONTAL_SPEED = 0
var vertical_speed

# Called when the node enters the scene tree for the first time.
func _ready():
	set_contact_monitor(true) # allows us to know if block is touching the ground
	
	# TO BE REPLACED ONCE ROUNDS START CHANGING STUFF
	vertical_speed = 50 
	apply_central_force(Vector2(HORIZONTAL_SPEED, vertical_speed))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if contact_monitor:
		vertical_speed = 0
		apply_central_force(Vector2(HORIZONTAL_SPEED, vertical_speed));
