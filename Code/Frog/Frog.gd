extends Area3D
class_name Frog

@onready var graphics = $Graphics

@export var speed: float = 4.0 # m/s.

var main: Main
var current_position: Vector3
var target_position: Vector3
var weight: float = 0.0
var stride_length: float = 1.0


func _ready():
	area_entered.connect(OnAreaEntered)
	current_position = Vector3(0.0, 0.0, 0.0)
	graphics.hide()


func _physics_process(delta):
	if current_position != target_position:
		weight += speed * delta
		if weight >= 1.0:
			weight = 1.0
			current_position = target_position
		
		position = lerp(current_position, target_position, weight)
	else:
		if graphics.visible:
			if Input.is_action_just_pressed("move_left"):
				target_position.x -= stride_length
				graphics.rotation_degrees.y = 90.0
				weight = 0.0
			if Input.is_action_just_pressed("move_right"):
				target_position.x += stride_length
				graphics.rotation_degrees.y = -90.0
				weight = 0.0
			if Input.is_action_just_pressed("move_fore"):
				target_position.z -= stride_length
				graphics.rotation_degrees.y = 0.0
				weight = 0.0
			if Input.is_action_just_pressed("move_back"):
				target_position.z += stride_length
				graphics.rotation_degrees.y = 180.0
				weight = 0.0





func OnAreaEntered(area):
	if area is Vehicle:
		print("Hit by a car.")
	
	if area is Nest:
		if area.is_occupied == false:
			area.is_occupied = true
			print("Roosting!!!!")
		main.IsGameOver()
	
	if area is River:
		print("Drowned in river.")
		
	if area is Vessel:
		print("Riding the log!!")
	
