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
	player.SetPositionUI(players.size())
	player.SetPosition3D(players.size())
	players.append(player)
	add_child(player)
