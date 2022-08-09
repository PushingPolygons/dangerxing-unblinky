extends Area
class_name River

# HACK: Code Duplication from Lane.
const VESSEL = preload("res://Vessel/Vessel.tscn")

# Expose to the editor.
export var speed_limit = 8.0
export var spawn_countdown = 1.0


func _ready():
	$Timer.wait_time = spawn_countdown


func SpawnVessel():
	var vessel = VESSEL.instance()
	vessel.Initialize($Spawn.translation, speed_limit, $Despawn.translation.z)
	add_child(vessel)


func _on_Timer_timeout():
	SpawnVessel()
