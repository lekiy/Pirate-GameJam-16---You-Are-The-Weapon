extends Camera2D

const ENEMY = preload("res://enemies/enemy.tscn")
@onready var main_layer: Node2D = $"../MainLayer"

var target
var velocity
var look_ahead = 0.15


func _process(delta: float) -> void:
	var player: Node2D = get_tree().get_first_node_in_group("Player")
	if player:
		var player_pos = player.global_position
		var mouse_position = get_global_mouse_position()
		target = lerp(player_pos, mouse_position, look_ahead)
		
	global_position = lerp(global_position, target, 1.0 - exp(-delta * 10))
	
	

	
