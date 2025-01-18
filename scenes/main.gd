extends Node

const ENEMY = preload("res://enemies/enemy.tscn")
const POSESSABLE = preload("res://environment/possessables/posessable.tscn")

@onready var main_layer: Node2D = $MainLayer
@onready var respawn_timer: Timer = $"Respawn Timer"
@onready var main_camera: Camera2D = $"Main Camera"

var enemy_spawn_range = 7000
var respawn_delay = 1
var possessables_count = 20

func _ready() -> void:
	respawn_timer.timeout.connect(spawn_enemy)
	
func _process(delta: float) -> void:
	respawn_possessables()


func spawn_enemy():
	var position = Vector2.RIGHT.rotated(deg_to_rad(randf_range(0, 360))) * Vector2(enemy_spawn_range, enemy_spawn_range*0.5)
	var enemy = ENEMY.instantiate()
	enemy.global_position = position
	main_layer.add_child(enemy)
	
func respawn_possessables():
	var diff = possessables_count - get_tree().get_nodes_in_group("Possessable").size()
	for i in diff:
		var range_dif = randf_range(1500, 3000)
		var position = Vector2.RIGHT.rotated(deg_to_rad(randf_range(0, 360))) * Vector2(range_dif, range_dif*0.5)
		var possessable = POSESSABLE.instantiate()
		possessable.global_position = main_camera.global_position+position
		main_layer.add_child(possessable)
