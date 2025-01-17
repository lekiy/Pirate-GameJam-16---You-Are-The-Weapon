class_name Player extends CharacterBody2D

@onready var sprite: Sprite2D = $Sprite2D

const SPEED = 300.0

var possessing = false

func _physics_process(delta: float) -> void:
	handle_movement()
	
	if Input.is_action_just_pressed("interact"):
		if possessing:
			for child in get_children():
				if child is Possessable:
					if child.can_be_unpossessed:  
						child._on_unpossess()
						child.reparent(get_parent())
						on_unpossess()
					else:
						print("cannot unpossess")
						
	if Input.is_action_just_pressed("attack"):
		if possessing:
			for child in get_children():
				if child is Possessable:
					if child.can_be_unpossessed:  
						child.reparent(get_parent())
						child.on_attack()
						on_unpossess()
					
					
func handle_movement():
	var move_direction = Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_up", "move_down"))
	
	velocity = move_direction*SPEED
	move_and_slide()


func on_possess(object: Possessable):
	sprite.visible = false
	possessing = true
	
func on_unpossess():
	sprite.visible = true
	possessing = false
