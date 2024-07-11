extends PanelContainer
class_name Menu

@onready var play_button = $VBox/PlayButton
@onready var options_button = $VBox/OptionsButton
@onready var quit_button = $VBox/QuitButton

var main: Main


func _ready():
	play_button.pressed.connect(OnPlayPressed)
	quit_button.pressed.connect(OnQuitPressed)
	main = get_parent()


func _process(delta):
	if Input.is_action_just_pressed("pause"):
		if not visible:
			show()
			get_tree().paused = true
		else:
			hide()
			get_tree().paused = false


func OnPlayPressed():
	hide()
	get_tree().paused = false
	main.frog.graphics.show()


func OnQuitPressed():
	get_tree().quit()
