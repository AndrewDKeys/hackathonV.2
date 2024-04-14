extends Timer

const POWER_UP_ODDS = 0.20
const SUPER_POWER_UP_ODDS = 0.05

var bubble
var dash
var bomb

var triple_jump
var full_clear
var slingshot
var permanent_dash

var chance

# Called when the node enters the scene tree for the first time.
func _ready():
	wait_time = 12


func _on_timeout():
	randomize()
	chance = randf() # creates a num 0.0 - 1.0
	if chance <= SUPER_POWER_UP_ODDS:
		gen_power_up()
		wait_time = 12
	elif chance <= POWER_UP_ODDS:
		gen_super_power_up()
		wait_time = 12
	else:
		wait_time /= 2

func gen_power_up():
	pass

func gen_super_power_up():
	pass
