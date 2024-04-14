extends Timer

const DROP_HEIGHT = -70
const POWER_UP_ODDS = 0.20
const SUPER_POWER_UP_ODDS = 0.10

var bubble = preload("res://power_ups/bubble.tscn")
var bomb = preload("res://power_ups/bomb.tscn")

var triple_jump = preload("res://power_ups/triple_jump.tscn")
var full_clear = preload("res://power_ups/full_clear.tscn")
var slingshot = preload("res://power_ups/sling_shot.tscn")

var chance

# Called when the node enters the scene tree for the first time.
func _ready():
	wait_time = 12


func _on_timeout():
	randomize()
	chance = randf() # creates a num 0.0 - 1.0
	if chance <= SUPER_POWER_UP_ODDS:
		wait_time = 12
		gen_super_power_up()
	elif chance <= POWER_UP_ODDS:
		wait_time = 12
		gen_power_up()
	else:
		wait_time /= 2

func gen_power_up():
	randomize()
	var power_list = [bomb, bubble, bomb]
	var random = power_list[randi() % power_list.size()]
	var power = random.instantiate()
	power.set_global_position(Vector2(randf_range(375, 830), DROP_HEIGHT))
	add_child(power)

func gen_super_power_up():
	randomize()
	var power_list = [triple_jump, full_clear, slingshot]
	var random = power_list[randi() % power_list.size()]
	var power = random.instantiate()
	power.set_global_position(Vector2(randf_range(375, 830), DROP_HEIGHT))
	add_child(power)
