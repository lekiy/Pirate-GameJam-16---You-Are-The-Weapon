class_name StateIdle extends State

@export var body : CharacterBody2D
@export var move_speed := 100
@export var idle_range := 1000
@export var next_state : State

var move_direction : Vector2
var wander_time: float

var player : CharacterBody2D

func randomize_wander():
	move_direction = Vector2.RIGHT.rotated(deg_to_rad(randf_range(0, 360)))
	wander_time = randf_range(1, 3)

func state_enter():
	player = get_tree().get_first_node_in_group("Player")
	randomize_wander()
	
func state_process(delta: float):
	if wander_time > 0:
		wander_time -= delta
	else:
		randomize_wander()

func state_physics_process(delta: float):
	if body:
		body.velocity = move_direction * move_speed
		
	if is_instance_valid(player):
		var direction = player.global_position - body.global_position
		if direction.length() < idle_range:
			if next_state:
				transitioned.emit(self, next_state.name)
			else:	
				transitioned.emit(self, "StateFollow")
	else:
		player = get_tree().get_first_node_in_group("Player")
