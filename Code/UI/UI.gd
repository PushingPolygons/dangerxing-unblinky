extends Control
class_name UI

const LIFE: PackedScene = preload("res://Main/assets/life.tscn")
const MAX_LIFE_SPAN: float = 15.0

@onready var lives_ui = $SideBar/VBox/LivesUI
@onready var progress_bar = $SideBar/VBox/ProgressBar
@onready var score_ui = $ScorePanel/ScoreUI


@export var drain_life: bool = true

var main: Main
var frog: Frog

var score: int = 0
var lives: int = 0
var life_span: float = MAX_LIFE_SPAN # seconds.


func _ready():
	#hide()
	progress_bar.max_value = MAX_LIFE_SPAN
	progress_bar.value = MAX_LIFE_SPAN
	Tools.DeleteChildren(lives_ui)
	UpdateScore(0)
	UpdateLives(3)


func _process(delta):
	if not frog.is_living and drain_life:
		life_span -= delta
		progress_bar.value = life_span
		# TODO: How do I scale these numbers?
		if life_span <= 0:
			frog.DeadOrAlive(false)

	
	if Input.is_action_just_pressed("spawn_frog"):
		if frog.weight >= 1.0 and frog.graphics.visible == false:
			if not frog.is_living:
				UpdateLives(-1)
			
			frog.Rez()
			life_span = MAX_LIFE_SPAN
			progress_bar.value = MAX_LIFE_SPAN
			print("Spawn frog: -1 life? ", lives)


func Initialize(main: Main, frog: Frog):
	self.main = main
	self.frog = frog
	frog.ui = self


func UpdateScore(delta_score: int):
	score += delta_score
	score_ui.text = str(score)


func UpdateLives(delta_lives):
	lives += delta_lives
	Tools.DeleteChildren(lives_ui)
	for life in lives:
		SpawnLifeIcon()


func SpawnLifeIcon():
	var life_icon = LIFE.instantiate()
	lives_ui.add_child(life_icon)
