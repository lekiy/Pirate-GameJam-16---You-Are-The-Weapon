extends Node2D

const PLAYER = preload("res://player/player.tscn")
var player: Player

func _ready() -> void:
	#RoomController.enter_room.connect(on_enter_room)
	spawn_player(RoomController.spawn_position)

#func on_enter_room(entry: EntryTrigger):
	#var position = Vector2.ZERO
	#if entry:
		#position = entry.entry_point.global_position
	#else:	
		#print("entry not found")
		#
	#spawn_player(position)
		#

func spawn_player(position: Vector2):
	if not player:
		var node = PLAYER.instantiate()
		var layer = get_tree().get_first_node_in_group("MainLayer")
		node.global_position = position
		print(position)
		layer.add_child.call_deferred(node)
