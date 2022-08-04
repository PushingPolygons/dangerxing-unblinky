extends Area
class_name Player

var speed = 2.0

func _process(delta):
	if Input.is_action_just_pressed("move_forward"):
		translation.z += -speed
	if Input.is_action_just_pressed("move_back"):
		translation.z += speed
	if Input.is_action_just_pressed("move_left"):
		translation.x += -speed
	if Input.is_action_just_pressed("move_right"):
		translation.x += speed
