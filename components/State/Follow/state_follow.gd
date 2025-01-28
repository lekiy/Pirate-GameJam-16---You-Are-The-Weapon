class_name StateFollow extends State

@export var body : CharacterBody2D
@export var move_speed := 500.0
@export var circle_range := 600.0
@export var idle_range := 1200.0

@export var next_state : State

var target: CharacterBody2D

func state_enter():
	target = get_tree().get_first_node_in_group("Player")
	
func state_physics_process(delta: float):
	if is_instance_valid(target):
		var direction = target.global_position - body.global_position
		
		if direction.length() > circle_range:
			body.velocity = direction.normalized() * move_speed
		else:
			if next_state:
				transitioned.emit(self, next_state.name)
			else:
				transitioned.emit(self, "StateCircle")
			
		if direction.length() > idle_range:
			transitioned.emit(self, "StateIdle")
