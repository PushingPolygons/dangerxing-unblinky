extends Area
class_name Player

# Asset Loading.
var movement_audio : Array
var death_audio : Array
var goal_audio : Array

# Logic
var main : Node
var speed = 2.0
var lives = 4 # Decrement on Player Spawn.
var offset_ui = 200 # Pixels.
var offset_3d = 3 # Meters.
var parent_vessel: Vessel = null
var is_alive = false


func _ready():
	movement_audio.append($move_0)
	movement_audio.append($move_1)
	UpdateLives(-1)
	is_alive = true


func _process(delta):
	if parent_vessel != null:
		translation.x = parent_vessel.translation.z

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


func SetPositionUI(player_count):
	$UI.rect_position.x += player_count * offset_ui


func SetPosition3D(player_count):
	translation.x += player_count * offset_3d


func UpdateLives(value):
	if value < 0:
		is_alive = false
		$Chicken.hide()
		$Tomb.show()
	
	lives += value
	$UI/Label.text = str(lives)
	if lives <= 0:
		main.IsGameOver()
		print("Tell Main we are done so it can wait fro others ot fiish.")
		#queue_free()


func PlayRandomSound(array):
	var rando = randi() % array.size()
	array[rando].play()
	#print(rando)


func _on_Player_area_entered(area):
	if is_alive:
		if area is Vehicle:
			UpdateLives(-1)
			is_alive = false
			print("Hey a car hit me.")
		
		if area is Vessel:
			parent_vessel = area
			print("Riding a boat.")
			# TODO: Vessel list
			# Reparent to boat.
			# or update positon to boat.
		
		if area is River:
			if parent_vessel == null:
				UpdateLives(-1)
				is_alive = false
				print("Fell in river.")
		
		if area is Goal:
			print("Landed on a goal.")
		# TODO:
		# Ends somehow.
		# tell main that one of our gaols is complete.
