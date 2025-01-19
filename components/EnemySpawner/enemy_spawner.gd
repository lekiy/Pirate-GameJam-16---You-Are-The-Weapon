class_name EnemySpawner extends Node2D

@export var enemy_scene = preload("res://enemies/enemy.tscn")
@export var enabled := true

func _ready() -> void:
	$Sprite2D.visible = false
	$SpawnTimer.timeout.connect(spawn_enemy)
	
func spawn_enemy():
	if enabled:
		var enemy: Enemy = enemy_scene.instantiate()
		var layer = get_tree().get_first_node_in_group("MainLayer")
		if layer:
			enemy.global_position = global_position
			layer.add_child(enemy)
