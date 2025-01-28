class_name EnemySecrit extends Enemy

@export var attack_wait_time = 4
var wait_time := 0.0
var last_instance : Node2D

func _process(delta: float) -> void:
	if get_tree().get_first_node_in_group("Player"):
		wait_time += delta
		if wait_time >= attack_wait_time:
			$StateManager.current_state.transitioned.emit($StateManager.current_state, "StateGoldStorm")
			wait_time = 0
	if not is_instance_valid(last_instance):
		$Marker2D/GPUParticles2D.emitting = false
