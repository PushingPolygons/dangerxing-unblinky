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


func RezFrog():
	frog.Rez()

func IsGameOver():
	for nest: Nest in nests:
		print(nest.is_occupied)
		if not nest.is_occupied:
			return
	menu.show()
	# TODO: Retart? Success / failure.

