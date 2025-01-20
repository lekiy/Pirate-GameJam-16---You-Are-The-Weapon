class_name StateFollow extends State

@export var body : CharacterBody2D
@export var move_speed := 400

var target: CharacterBody2D

func state_enter():
	target = get_tree().get_first_node_in_group("Player")
	
func state_physics_process(delta: float):
	var direction = target.global_position - body.global_position
	
	if direction.length() > 250:
		body.velocity = direction.normalized() * move_speed
	else:
		body.velocity = Vector2()
		
	if direction.length() > 500:
		transitioned.emit(self, "StateIdle")
