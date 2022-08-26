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

	#var wait =  rand_range(0.0, 1.0)
	var wait = randi() % 4
	
	print(wait)
	wait += 0.01
	if wait >= 0:
		$Timer.wait_time = wait
#		$Timer.wait_time = randi() % 1 + 1 # 


func _on_Timer_timeout():
	SpawnVessel()
