extends Area
class_name Vessel

# HACK: Code dup. from Vehicle. Should be a single class?
var speed = 8.0 # / sec.
var despawn_border


func Initialize(new_position, new_speed, new_despawn_border):
	translation = new_position
	speed = new_speed
	despawn_border = new_despawn_border


func _process(delta):
	translate_object_local(Vector3(0.0, 0.0, -speed) * delta)
	if translation.z < despawn_border:
		queue_free()
