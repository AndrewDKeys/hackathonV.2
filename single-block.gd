extends RigidBody2D

var vertical_speed

# Called when the node enters the scene tree for the first time.
func _ready():
	set_contact_monitor(true) # allows us to know if block is touching the ground
	
	# TO BE REPLACED ONCE ROUNDS START CHANGING STUFF
	vertical_speed = 50 
	linear_velocity = Vector2(0, 50)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	if contact_monitor:
		vertical_speed = 0
		apply_central_force(Vector2(0, vertical_speed));
