extends Node

const PLAYER = preload("res://Player/Player.tscn")

var players : Array


func _ready():
	SpawnPlayer()
#	SpawnPlayer()
#	SpawnPlayer()
#	SpawnPlayer()


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
