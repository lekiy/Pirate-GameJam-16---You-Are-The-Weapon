class_name Enemy extends CharacterBody2D

var knockback_velocity = Vector2()

func _on_interact():
	
	var player = get_tree().get_first_node_in_group("Player")
	if player:
		$Posessable.possess(player)

func _physics_process(delta: float) -> void:
	velocity += knockback_velocity
	knockback_velocity *= 0.8
	move_and_slide()
	
	if velocity.x > 1:
		$Sprite2D.flip_h = true
	elif velocity.x < 1:
		$Sprite2D.flip_h = false
		

func knock_back(knockback_direction: Vector2, knockback_force: float):
	knockback_velocity += knockback_direction.normalized()*knockback_force
	
