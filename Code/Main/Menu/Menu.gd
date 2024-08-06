extends PanelContainer
class_name Menu

@onready var message = $VBox/Message
@onready var play_button = $VBox/PlayButton
@onready var replay_button = $VBox/ReplayButton
@onready var options_button = $VBox/OptionsButton
@onready var quit_button = $VBox/QuitButton
@onready var animation_player = $AnimationPlayer

var main: Main


func PauseGame(paused: bool):
	get_tree().paused = paused


func _ready():
	play_button.pressed.connect(OnPlayPressed)
	replay_button.pressed.connect(OnReplayPressed)
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


func Show(new_message: String):
	show()
	animation_player.play("Boing", -1, 3.3, false)
	message.text = new_message


func OnPlayPressed():
	get_tree().paused = false
	main.Play()
	animation_player.play("Boing", -1, -3.3, false) # HACK: Not animating.


func OnReplayPressed():
	get_tree().reload_current_scene()


func OnQuitPressed():
	get_tree().quit()
