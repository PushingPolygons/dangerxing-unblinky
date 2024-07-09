extends Area3D
class_name Frog

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

var velocity: Vector3 = Vector3.ZERO


func _ready():
	area_entered.connect(OnAreaEntered)


func _physics_process(delta):
	var input_dir = Input.get_vector("move_left", "move_right", "move_fore", "move_back")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	position += velocity * delta


func OnAreaEntered(area):
	if area is Vehicle:
		print("Hit by a car.")
	
	if area is Nest:
		if area.is_occupied == false:
			area.is_occupied = true
			print("Roosting!!!!")
	
	if area is River:
		print("Drowned in river.")
		
	if area is Vessel:
		print("Riding the log!!")
	
