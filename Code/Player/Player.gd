extends Area
class_name Player

func _process(delta):
	if Input.is_action_just_pressed("move_forward"):
		translation.z += -1.0
		$Move_0.play()
		$Move_1.play()
