extends PanelContainer
class_name Menu

@onready var play_button = $VBox/PlayButton
@onready var options_button = $VBox/OptionsButton
@onready var quit_button = $VBox/QuitButton
@onready var animation_player = $AnimationPlayer

var main: Main


func PauseGame(paused: bool):
	get_tree().paused = paused


func _ready():
	play_button.pressed.connect(OnPlayPressed)
	quit_button.pressed.connect(OnQuitPressed)
	main = get_parent()
	animation_player.play("Boing", -1, 3.3, false)


func _process(delta):
	if Input.is_action_just_pressed("pause"):
		if not visible:
			get_tree().paused = true
			animation_player.play("Boing", -1, 3.3, false)
		else:
			get_tree().paused = false
			animation_player.play("Boing", -1, -3.3, true)


func OnPlayPressed():

	animation_player.play("Boing", -1, 3.3, false)
	get_tree().paused = false
	main.Play()


func OnQuitPressed():
	get_tree().quit()
