extends Node2D

const PLAYER = preload("res://player/player.tscn")
var player: Player

func _ready() -> void:
	spawn_player(RoomController.spawn_position)
	

func spawn_player(position: Vector2):
	if not player:
		var node = PLAYER.instantiate()
		var layer = get_tree().get_first_node_in_group("MainLayer")
		node.global_position = position
		layer.add_child.call_deferred(node)
