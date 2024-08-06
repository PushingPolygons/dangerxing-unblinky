extends Node
class_name Main

@onready var menu = $Menu
@onready var nests: Array[Nest] = [$Nests/Nest1, $Nests/Nest2, $Nests/Nest3, $Nests/Nest4, $Nests/Nest5]
@onready var frog = $Frog


func _ready():
	frog.main = self
	frog.ui.Initialize(self, frog)


func IsGameOver(ui: UI):
	# Losing condition.
	if ui.lives <= 0:
		print("UI.lives: ", ui.lives)
		menu.Open("You stink loser!")
		ui.hide()
		return
	
	# Win Condition.
	for nest: Nest in nests:
		if not nest.is_occupied:
			return
	menu.Open("Congradulations!")
	ui.hide()
	

