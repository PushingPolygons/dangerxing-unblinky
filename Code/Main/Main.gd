extends Node
class_name Main

const LIFE: PackedScene = preload("res://Main/assets/life.tscn")

@onready var lives_ui = $Menu/VBox/LivesUI


var lives: int = 3


func _ready():
	UpdateLives(3)


func UpdateLives(delta_lives):
	lives += delta_lives
	for i in delta_lives:
		SpawnLife()
	print(lives)


func SpawnLife():
	var life = LIFE.instantiate()
	#var my_copy = life.duplicate()
	
	lives_ui.add_child(life)
	#lives_ui.add_child(my_copy)
