extends Node

const ROOM_BASE = preload("res://rooms/RoomBase.tscn")

var player: Player
var spawn_position : Vector2 = Vector2.ZERO

var room_dict = {
	"room_base": ROOM_BASE
}

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Reset"):
		get_tree().reload_current_scene()

func move_to_room(room_name, entry_name):
	print("moving to room "+str(room_name)+" at entry "+str(entry_name))
	
	player.get_parent().remove_child(player)
	var room = room_dict[room_name]
	if room:
		get_tree().change_scene_to_packed.call_deferred(room)
	else:
		print("Room not registered: "+room_name)
		
	var entry: EntryTrigger = get_entry(entry_name)
	spawn_position = entry.entry_point.global_position
	


func get_entry(entry_name):
	var entries = get_tree().get_nodes_in_group("Entry")
	for entry in entries:
		if entry is EntryTrigger:
			if entry.entry_name == entry_name:
				return entry
	print("Entry: "+entry_name+" not found")
	return null
	
	
