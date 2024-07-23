extends Area3D
class_name Frog

@onready var graphics = $Graphics

@export var speed: float = 4.0 # m/s.
#@export var reset_speed: float = 0.5

var main: Main
var current_position: Vector3
var target_position: Vector3
var weight: float = 0.0
var stride_length: float = 1.0

var is_dead: bool = true
var vessel: Vessel = null
var seat_offset: Vector3 = Vector3.ZERO


func _ready():
	area_entered.connect(OnAreaEntered)
	area_exited.connect(OnAreaExited)
	current_position = Vector3(0.0, 0.0, 0.0)
	graphics.hide()




func _physics_process(delta):
	if vessel != null:
		global_position = vessel.global_position + seat_offset
		
	
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
		#else:
			# Turn the frog back on after reset.
			#graphics.show()


func Rez():
	is_dead = false
	graphics.show()


func Die():
	main.IsGameOver()
	is_dead = true
	graphics.hide()
	target_position = Vector3.ZERO


func OnAreaEntered(area):
	
	if area is Nest:
		if area.is_occupied == false:
			area.SetOccupied(true)
			#area.is_occupied = true
			print("Roosting!!!!")
			target_position = Vector3.ZERO
			graphics.hide()
		main.IsGameOver()
	
	#if area is River and vessel == null:
		#Die()
		#print("Drowned in river.")
	
	if area is Vessel:
		vessel = area
		seat_offset.x = floorf(global_position.distance_to(area.global_position))
		print("Riding the log!!: ", seat_offset)
	elif area is Vehicle:
		Die()
		print("Hit by a car.")


func OnAreaExited(area):
	if area is Vessel:
		vessel = null
		print("Jumped off log.")
