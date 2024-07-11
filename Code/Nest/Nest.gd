extends Area3D
class_name Nest

@onready var frog = $Graphics/Frog
var is_occupied: bool = false


func _ready():
	frog.hide()


func SetOccupied(b: bool):
	is_occupied = b
	frog.show()
