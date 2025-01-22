class_name StateLungeAttack extends State

@export var body : CharacterBody2D
@export var lunge_speed := 700.0
@export var lunge_distance := 800.0
@export var lunge_charge_time := 1

@export var hurtbox = HurtBox

const ARROW_TELEGRAPH = preload("res://components/Telegraph/arrow_telegraph.tscn")

var lunge_direction
var lunge_start_pos
var lunge_wait_time

var target: CharacterBody2D

func state_enter():
	target = get_tree().get_first_node_in_group("Player")
	lunge_direction = (target.global_position - body.global_position).normalized()
	lunge_start_pos = body.global_position
	lunge_wait_time = lunge_charge_time
	
	var telegraph: Telegraph = ARROW_TELEGRAPH.instantiate()
	telegraph.duration = lunge_wait_time
	telegraph.direction = lunge_direction
	body.add_child(telegraph)
	$GPUParticles2D.emitting = true
	
func state_physics_process(delta: float):
	lunge_wait_time -= delta
	if lunge_wait_time > 0:
		body.velocity = Vector2()
	else:
		body.velocity = lunge_direction * lunge_speed
		
	if body.global_position.distance_to(lunge_start_pos) > lunge_distance:
		transitioned.emit(self, "StateCircle")

func state_exit():
	$GPUParticles2D.emitting = false
