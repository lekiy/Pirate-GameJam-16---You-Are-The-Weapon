extends Node2D

const ENEMY = preload("res://enemies/enemy.tscn")
const PLAYER = preload("res://player/player.tscn")

var player: Player

func _ready() -> void:
	spawn_player(RoomController.spawn_position)
	spawn_enemies()

func get_spawn_position():
	var entry: EntryTrigger = RoomController.get_entry()
	if entry: 
		print(entry.entry_point.global_position)
		return entry.entry_point.global_position

func spawn_player(spawn_position: Vector2):
	print(RoomController.player)
	if RoomController.player and is_instance_valid(RoomController.player):
		print("using old player")
		#if player:
			#player.queue_free()
		player = RoomController.player
		var layer = get_tree().get_first_node_in_group("MainLayer")
		player.global_position = get_spawn_position()
		layer.add_child(player)
		player.on_enter_room()
	else:
		print("spawning new player")
		var layer = get_tree().get_first_node_in_group("MainLayer")
		player = PLAYER.instantiate()
		player.global_position = spawn_position
		layer.add_child.call_deferred(player)
		RoomController.player = player

func spawn_enemies():
	if not $EnemySpawnPoints:
		return
	var spawn_points = $EnemySpawnPoints.get_children()
	var layer = get_tree().get_first_node_in_group("MainLayer")
	for point: Marker2D in spawn_points:
		var enemy: Enemy = ENEMY.instantiate()
		enemy.global_position = point.global_position
		layer.add_child(enemy)
		
