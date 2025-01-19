class_name Enemy extends CharacterBody2D

const SPEED = 200.0

func _physics_process(delta: float) -> void:
	var target = global_position
	var player = get_tree().get_first_node_in_group("Player")
	if player:
		target = player.global_position
		
	
	velocity = global_position.direction_to(target)*SPEED

	move_and_slide()
