extends Area3D
class_name Frog

@onready var graphics = $Graphics
@onready var ui = $UI

@export var speed: float = 4.0 # m/s.
#@export var reset_speed: float = 0.5

var main: Main

const stride_pan: float = 0.15 # unit?
const dead_pan: float = 2.3

var current_position: Vector3
var target_position: Vector3
var weight: float = 0.0

var is_living: bool = false
var vessel: Vessel = null
var seat_offset: Vector3 = Vector3.ZERO
var use_stride_pan: bool = false


func _ready():
	area_entered.connect(OnAreaEntered)
	target_position = position
	current_position = target_position
	graphics.hide()


func _process(delta):
	if weight < 1.0:
		if vessel != null:
			target_position = vessel.global_position + seat_offset
			
		if use_stride_pan:
			weight += delta / stride_pan
		else:
			weight += delta / dead_pan
		position = lerp(current_position, target_position, weight)
		
		if weight >= 1.0:
			current_position = target_position
			#graphics.show()
	
	else:
		if graphics.visible:
			if vessel != null:
				position = vessel.global_position + seat_offset
				current_position = position
			
			if Input.is_action_just_pressed("move_left"):
				graphics.rotation_degrees.y = 90.0
				if vessel != null:
					seat_offset += Vector3.LEFT
					if seat_offset.x < 0.0:
						vessel = null
						DeadOrAlive(ui)
						print("Offset:", seat_offset)
				else:
					target_position = current_position + Vector3.LEFT
				weight = 0.0
			
			if Input.is_action_just_pressed("move_right"):
				graphics.rotation_degrees.y = -90.0
				if vessel != null:
					seat_offset += Vector3.RIGHT
					if seat_offset.x > vessel.seat_count - 1:
						vessel = null
						DeadOrAlive(ui)
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


func Rez():
	graphics.show()
	is_living = true
	use_stride_pan = true


func DeadOrAlive(new_living: bool):
	use_stride_pan = new_living
	
	#dead_pan = stride_pan * current_position.distance_to(target_position)
	main.IsGameOver(ui)
	graphics.hide()
	current_position = position
	target_position = Vector3.ZERO
	weight = 0.0
	ui.progress_bar.value = 0.0


func OnAreaEntered(area):
	if graphics.visible:
		
		if area is Nest:
			if area.is_occupied == false:
				area.SetOccupied(true)
				print("Roosting!!!!")
				DeadOrAlive(true)
		
		if area is Lane:
			ui.UpdateScore(10)
		
		if area is River:
			print("Splash")
			if vessel == null:
				DeadOrAlive(false)
				print("Drowned in river.")
		
		if area is Vessel:
			vessel = area
			seat_offset.x = round(global_position.x - area.global_position.x)
			seat_offset.x = clamp(seat_offset.x, 0.0, vessel.seat_count - 1)
			print("Offset:", seat_offset)
			print("Riding the log!!")
		elif area is Vehicle:
			DeadOrAlive(false)
			print("Hit by a car.")
