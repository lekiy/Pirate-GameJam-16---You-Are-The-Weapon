class_name StateFollow extends State

@export var body : CharacterBody2D
@export var move_speed := 300.0
@export var circle_range := 500.0
@export var idle_range := 1000.0

var target: CharacterBody2D

func state_enter():
	target = get_tree().get_first_node_in_group("Player")
	
func state_physics_process(delta: float):
	var direction = target.global_position - body.global_position
	
	if direction.length() > circle_range:
		body.velocity = direction.normalized() * move_speed
	else:
		transitioned.emit(self, "StateCircle")
		
	if direction.length() > idle_range:
		transitioned.emit(self, "StateIdle")
