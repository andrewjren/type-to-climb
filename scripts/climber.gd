extends CharacterBody2D

@onready var ray_up: RayCast2D = $RayUp

const SPEED = 100.0

var target = position
var falling = false

func update_target(new_target):
	target = new_target

func _physics_process(delta: float) -> void:
	
	
	if position.distance_to(target) > 1 and not falling:
		velocity = position.direction_to(target) * SPEED
		move_and_slide()
	
	if falling:
		if not is_on_floor():
			velocity += get_gravity() * delta
			move_and_slide()


func _on_countdown_out_of_stamina() -> void:
	falling = true
		
