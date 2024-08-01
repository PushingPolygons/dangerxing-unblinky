extends Area3D
class_name Frog

@onready var graphics = $Graphics

@export var speed: float = 4.0 # m/s.
#@export var reset_speed: float = 0.5

var main: Main
var ui: UI

var stride_length: float = 1.0
var dead_speed: float = 0.3

var current_position: Vector3
var target_position: Vector3
var weight: float = 0.0

var is_dead: bool = true
var vessel: Vessel = null
var seat_offset: Vector3 = Vector3.ZERO


func _ready():
	area_entered.connect(OnAreaEntered)
	target_position = position
	current_position = target_position
	graphics.hide()


func _process(delta):
	if weight < 1.0:
		if vessel != null:
			target_position = vessel.global_position + seat_offset
			
		if not is_dead:
			weight += delta / stride_length
		else:
			weight += delta / dead_speed
		position = lerp(current_position, target_position, weight)
		
		if weight >= 1.0:
			current_position = target_position
			graphics.show()
	
	else:
		if graphics.visible:
			if vessel != null:
				position = vessel.global_position + seat_offset
				current_position = position
			
			if Input.is_action_just_pressed("move_left"):
				graphics.rotation_degrees.y = 90.0
				if vessel != null:
					seat_offset += Vector3.LEFT
					print("Offset:", seat_offset)
				else:
					target_position = current_position + Vector3.LEFT
				weight = 0.0
			
			if Input.is_action_just_pressed("move_right"):
				graphics.rotation_degrees.y = -90.0
				if vessel != null:
					seat_offset += Vector3.RIGHT
					print("Offset:", seat_offset)
				else:
					target_position = current_position + Vector3.RIGHT
				weight = 0.0
			
			if Input.is_action_just_pressed("move_fore"):
				vessel = null
				graphics.rotation_degrees.y = 0.0
				target_position = round(current_position + Vector3.FORWARD)
				weight = 0.0

			
			if Input.is_action_just_pressed("move_back"):
				vessel = null
				graphics.rotation_degrees.y = 180.0
				target_position = round(current_position + Vector3.BACK)
				weight = 0.0


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
	
	if area is Lane:
		ui.UpdateScore(10)
	#if area is River and vessel == null:
		#Die()
		#print("Drowned in river.")
	
	if area is Vessel:
		vessel = area
		seat_offset.x = round(global_position.x - area.global_position.x)
		print("Offset:", seat_offset)
		print("Riding the log!!")
	#elif area is Vehicle:
		#Die()
		#print("Hit by a car.")

func Reposition():
	position = Vector3(0, 10, 0)

func OnAreaExited(area):
	#if area is Vessel:
		#vessel = null
		##current_position = global_position
		##target_position = global_position
		#print("Jumped off log.")
		pass
