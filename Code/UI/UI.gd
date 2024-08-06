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
	hide()
	# FIXME: Found a bug.
	# HACK: Max life span workaround.
	progress_bar.max_value = MAX_LIFE_SPAN
	progress_bar.value = MAX_LIFE_SPAN
	Tools.DeleteChildren(lives_ui)
	UpdateScore(0)
	UpdateLives(3)


func _process(delta):
	if not frog.is_dead and drain_life:
		life_span -= delta
		progress_bar.value = life_span
		# TODO: How do I scale these numbers?
		if life_span <= 0:
			frog.DeadOrAlive(true)

	
	if Input.is_action_just_pressed("spawn_frog"):
		if frog.weight >= 1.0 and frog.graphics.visible == false:
			if frog.is_dead:
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
	if lives < 0 and frog.is_dead:
		main.GameOver()
	else:
		Tools.DeleteChildren(lives_ui)
		for i in lives:
			SpawnLife()


func SpawnLife():
	var life = LIFE.instantiate()
	lives_ui.add_child(life)
