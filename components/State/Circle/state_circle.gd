class_name StateCircle extends State

@export var body : CharacterBody2D
@export var move_speed := 200.0
@export var attack_range := 550.0

var attack_delay := 1.0
var wait_time

var target: CharacterBody2D

func state_enter():
	target = get_tree().get_first_node_in_group("Player")
	wait_time = attack_delay
	
func state_physics_process(delta: float):
	wait_time -= delta
	var direction = target.global_position - body.global_position
	
	if wait_time <= 0:
		transitioned.emit(self, "StateLungeAttack")
		
	body.velocity = direction.normalized().rotated(deg_to_rad(90)) * move_speed
		
	if direction.length() > attack_range:
		transitioned.emit(self, "StateFollow")
