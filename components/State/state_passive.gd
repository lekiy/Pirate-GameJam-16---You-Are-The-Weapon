class_name StatePassive extends State

@export var body : CharacterBody2D

func state_enter():
	pass

func state_process(delta: float) -> void:
	pass
	
func state_physics_process(delta: float):
	if body:
		body.velocity = Vector2()

func state_exit():
	pass
