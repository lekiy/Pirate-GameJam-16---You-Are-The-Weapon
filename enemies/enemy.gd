class_name Enemy extends CharacterBody2D

func _physics_process(delta: float) -> void:
	move_and_slide()
	
	
	if velocity.x > 1:
		$Sprite2D.flip_h = true
	elif velocity.x < 1:
		$Sprite2D.flip_h = false
		
