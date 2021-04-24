extends KinematicBody2D

export var MOVE_SPEED = 80
export var MOVE_ACCEL = 500
export var FALL_SPEED = 100
export var FALL_ACCEL = 500
export var FRICTION = 500

var move_velocity = Vector2.ZERO
var fall_velocity = Vector2.ZERO

func _ready():
	pass

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
#	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	# Update move velocity based on input.
	if input_vector != Vector2.ZERO:
		move_velocity = move_velocity.move_toward(input_vector * MOVE_SPEED, MOVE_ACCEL * delta)
	else:
		move_velocity = move_velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	# Update fall velocity.
	fall_velocity = fall_velocity.move_toward(Vector2.DOWN * FALL_SPEED, FALL_ACCEL * delta)
	
	move()

func move():
	var actual_velocity = move_and_slide(move_velocity + fall_velocity)
	move_velocity.x = actual_velocity.x
	fall_velocity.y = actual_velocity.y
