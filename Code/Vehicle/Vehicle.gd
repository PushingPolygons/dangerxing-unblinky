extends Area3D
class_name Vehicle

var lane: Lane
var speed: float = 2.0
var spawn_point: float = 8.0


func _ready():
	lane = get_parent()
	speed = lane.speed_limit


func _process(delta):
	position.z -= speed * delta
	
	if position.z < -spawn_point:
		position.z = spawn_point
