extends Node
class_name Main

const LIFE: PackedScene = preload("res://Main/assets/life.tscn")

@onready var lives_ui = $Menu/VBox/LivesUI
@onready var nests: Array[Nest] = [$Nests/Nest1, $Nests/Nest2, $Nests/Nest3, $Nests/Nest4, $Nests/Nest5]
@onready var frog = $Frog

var lives: int = 3


static func DeleteChildren(node: Node):
	for child in node.get_children():
		#print(child.name)
		child.get_parent().remove_child(child)
		child.queue_free()



func _ready():
	DeleteChildren(lives_ui)
	UpdateLives(3)
	frog.main = self


func IsGameOver():
	for nest: Nest in nests:
		if not nest.is_occupied:
			return
	get_tree().quit()


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
