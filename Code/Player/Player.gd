extends Area
class_name Player

var speed = 2.0
var movement_audio : Array
var death_audio : Array
var goal_audio : Array


func _ready():
	movement_audio.append($move_0)
	movement_audio.append($move_1)
	
	#death_audio.append($move_1)


func _process(delta):
	if Input.is_action_just_pressed("move_forward"):
		translation.z += -speed
		rotation_degrees.y = 0
		PlayRandomSound(movement_audio)
		
	if Input.is_action_just_pressed("move_back"):
		translation.z += speed
		rotation_degrees.y = 180
		PlayRandomSound(movement_audio)
		
	if Input.is_action_just_pressed("move_left"):
		translation.x += -speed
		rotation_degrees.y = 90
		PlayRandomSound(movement_audio)
		
	if Input.is_action_just_pressed("move_right"):
		translation.x += speed
		rotation_degrees.y = -90
		PlayRandomSound(movement_audio)


func PlayRandomSound(array):
	var rando = randi() % array.size()
	array[rando].play()
	print(rando)
