extends Camera2D

# Using camera shake based on: https://kidscancode.org/godot_recipes/2d/screen_shake/

export var zoom_delta = 0.1
export var trauma_decay = 0.8
export var max_offset = Vector2(50, 50)  # Maximum hor/ver shake in pixels.
export var max_roll = 0.0  # Maximum rotation in radians (use sparingly).

onready var noise = OpenSimplexNoise.new()

var trauma = 0.0
var trauma_power = 2
var noise_y = 0

func _ready():
	noise.seed = randi()
	noise.period = 4
	noise.octaves = 2

func _process(delta):
	if Input.is_action_just_pressed("zoom_in"):
		zoom -= zoom_delta
	elif Input.is_action_just_pressed("zoom_out"):
		zoom += zoom_delta
	if trauma:
		trauma = max(trauma - trauma_decay * delta, 0)
		update_shake(delta)

func update_shake(delta):
	var amount = pow(trauma, trauma_power)
	var time = OS.get_splash_tick_msec()
	noise_y += 1
	rotation = max_roll * amount * noise.get_noise_2d(noise.seed, noise_y)
	offset.x = max_offset.x * amount * noise.get_noise_2d(noise.seed*2, noise_y)
	offset.y = max_offset.y * amount * noise.get_noise_2d(noise.seed*3, noise_y)

func start_shake(amount):
	trauma = amount
