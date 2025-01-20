class_name StateCircle extends State

@export var body : CharacterBody2D
@export var move_speed := 200.0
@export var attack_range := 550.0
@export var attack_delay_min := 1.0
@export var attack_delay_max := 2.0

var wait_time
var strafe_direction
var target: CharacterBody2D

func state_enter():
	target = get_tree().get_first_node_in_group("Player")
	wait_time = randf_range(attack_delay_min, attack_delay_max)
	strafe_direction = [1, -1].pick_random()*90
	
func state_physics_process(delta: float):
	wait_time -= delta
	var direction = target.global_position - body.global_position
	
	if wait_time <= 0:
		transitioned.emit(self, "StateLungeAttack")
		
	body.velocity = direction.normalized().rotated(deg_to_rad(strafe_direction)) * move_speed
		
	if direction.length() > attack_range:
		transitioned.emit(self, "StateFollow")
