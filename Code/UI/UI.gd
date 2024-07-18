extends PanelContainer
class_name UI

const LIFE: PackedScene = preload("res://Main/assets/life.tscn")

@onready var lives_ui = $VBox/LivesUI


var main: Main
var frog: Frog
var lives: int = 0


func _ready():
	hide()
	Tools.DeleteChildren(lives_ui)
	UpdateLives(3)



func _process(delta):
	if Input.is_action_just_pressed("spawn_frog"):
		if frog.is_dead:
			UpdateLives(-1)
			frog.Rez()



func Initialize(main: Main, frog: Frog):
	self.main = main
	self.frog = frog


func UpdateLives(delta_lives):
	lives += delta_lives
	Tools.DeleteChildren(lives_ui)
	for i in lives:
		SpawnLife()
	print(lives)


func SpawnLife():
	var life = LIFE.instantiate()
	lives_ui.add_child(life)
