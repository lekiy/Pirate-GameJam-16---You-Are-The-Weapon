extends Node2D

const PLAYER = preload("res://player/player.tscn")
var player: Player

func _ready() -> void:
	spawn_player(RoomController.spawn_position)
	

func spawn_player(spawn_position: Vector2):
	print(RoomController.player)
	if RoomController.player and is_instance_valid(RoomController.player):
		print("using old player")
		#if player:
			#player.queue_free()
		player = RoomController.player
		var layer = get_tree().get_first_node_in_group("MainLayer")
		layer.add_child(player)
		player.global_position = spawn_position
		player.on_enter_room()
	else:
		print("spawning new player")
		var layer = get_tree().get_first_node_in_group("MainLayer")
		player = PLAYER.instantiate()
		player.global_position = spawn_position
		layer.add_child.call_deferred(player)
		RoomController.player = player
