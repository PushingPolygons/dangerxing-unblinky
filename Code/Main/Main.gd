extends Node
class_name Main

@onready var ui = $UI
@onready var menu = $Menu
@onready var nests: Array[Nest] = [$Nests/Nest1, $Nests/Nest2, $Nests/Nest3, $Nests/Nest4, $Nests/Nest5]
@onready var frog = $Frog


func _ready():
	frog.main = self
	ui.Initialize(self, frog)


func Play():
	ui.show()


func IsGameOver():
	
	# TODO: Make game end.
	# Losing condition.
	if ui.lives <= 0:
		print("UI.lives: ", ui.lives)
		menu.Show("You stink loser!")
		ui.hide()
		return
	
	# Win Condition.
	for nest: Nest in nests:
		if not nest.is_occupied:
			return
	menu.Show("Congradulations loser!")
	ui.hide()
	

