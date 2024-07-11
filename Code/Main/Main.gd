extends Node
class_name Main

const LIFE: PackedScene = preload("res://Main/assets/life.tscn")

# Menu items.
@onready var menu = $Menu
@onready var play_button = $Menu/VBox/PlayButton
@onready var options_button = $Menu/VBox/OptionsButton
@onready var quit_button = $Menu/VBox/QuitButton

@onready var lives_ui = $UI/VBox/LivesUI
@onready var nests: Array[Nest] = [$Nests/Nest1, $Nests/Nest2, $Nests/Nest3, $Nests/Nest4, $Nests/Nest5]
@onready var frog = $Frog

var lives: int = 3


static func DeleteChildren(node: Node):
	for child in node.get_children():
		#print(child.name)
		child.get_parent().remove_child(child)
		child.queue_free()



func _ready():
	play_button.pressed.connect(OnPlayPressed)
	
	DeleteChildren(lives_ui)
	UpdateLives(3)
	frog.main = self


func OnPlayPressed():
	menu.hide()
	frog.graphics.show()


func IsGameOver():
	print(nests)
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
