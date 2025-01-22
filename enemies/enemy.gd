class_name Enemy extends CharacterBody2D

func _on_interact():
	
	var player = get_tree().get_first_node_in_group("Player")
	if player:
		$Posessable.possess(player)

func _physics_process(delta: float) -> void:
	move_and_slide()
	
	
	if velocity.x > 1:
		$Sprite2D.flip_h = true
	elif velocity.x < 1:
		$Sprite2D.flip_h = false
		
