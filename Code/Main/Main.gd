extends Node

const PLAYER = preload("res://Player/Player.tscn")

var players : Array
export var mouse_x_sensitivity = 0.01
export var mouse_y_sensitivity = 0.01



func _ready():
	randomize()
	SpawnPlayer()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
#	SpawnPlayer()
#	SpawnPlayer()
#	SpawnPlayer()


func _input(event):
	if event is InputEventMouseMotion:
		$LCA/CameraRig/Camera.global_rotate(Vector3.UP, event.get_relative().x * -mouse_x_sensitivity)
		$LCA/CameraRig/Camera.rotate_object_local(Vector3.RIGHT, event.get_relative().y * -mouse_y_sensitivity)
		print(event.get_relative().y)

#	$Camera.rotate_y(event.get_relative().x
#	print(event.get_relative().x)

func _unhandled_input(event):
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()


func SpawnPlayer():
	var player = PLAYER.instance()
	player.main = self
	player.SetPositionUI(players.size())
	player.SetPosition3D(players.size())
	players.append(player)
	add_child(player)


# TODO: Untested.
func IsGameOver():
	# Are all the players out?
	for player in players:
		if player.is_out == false: # TODO: player.lives > 0:
			return false
			
	# Game is over.
	# TODO: Display UI > Main Menu
	return true
