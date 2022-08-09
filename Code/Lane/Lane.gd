extends Spatial
class_name Lane

const VEHICLE = preload("res://Vehicle/Vehicle.tscn")

# Expose to the editor.
export var speed_limit = 8.0
export var spawn_countdown = 1.0


func _ready():
	$Timer.wait_time = spawn_countdown


func SpawnVehicle():
	var vehicle = VEHICLE.instance()
	vehicle.Initialize($Spawn.translation, speed_limit, $Despawn.translation.z)
	add_child(vehicle)


func _on_Timer_timeout():
	SpawnVehicle()
