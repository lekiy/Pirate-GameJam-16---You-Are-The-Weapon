class_name StateAvoid extends State


@export var body : CharacterBody2D
@export var move_speed := 400.0
@export var circle_range := 800.0
@export var idle_range := 1600.0


var target: CharacterBody2D

func state_enter():
	target = get_tree().get_first_node_in_group("Player")
	
func state_physics_process(delta: float):
	if is_instance_valid(target):
		var direction = -(target.global_position - body.global_position)
		
		if direction.length() < circle_range:
			body.velocity = direction.normalized() * move_speed
		else:
			body.velocity = Vector2.ZERO
			
		if direction.length() > circle_range:
			transitioned.emit(self, "StateFollow")
			
		if direction.length() > idle_range:
			transitioned.emit(self, "StateIdle")
