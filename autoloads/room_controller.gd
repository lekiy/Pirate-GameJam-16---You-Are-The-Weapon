extends Node

const ROOM_TEST = preload("res://rooms/RoomTest.tscn")
const ROOM_ENTRY = preload("res://rooms/room_entry.tscn")
const ROOM_LIVING = preload("res://rooms/room_living.tscn")
const ROOM_LIBRARY = preload("res://rooms/room_library.tscn")
const ROOM_KITCHEN = preload("res://rooms/room_kitchen.tscn")

var player: Player
var spawn_position : Vector2 = Vector2.ZERO
var current_room_name: String
var current_entry_name: String

var room_dict = {
	"room_test": ROOM_TEST,
	"room_entry": ROOM_ENTRY,
	"room_living": ROOM_LIVING,
	"room_library": ROOM_LIBRARY,
	"room_kitchen": ROOM_KITCHEN
}

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Reset"):
		get_tree().reload_current_scene()

func move_to_room(room_name, entry_name):
	print("moving to room "+str(room_name)+" at entry "+str(entry_name))
	
	player.get_parent().remove_child(player)
	var room = room_dict[room_name]
	if room:
		current_room_name = room_name
		current_entry_name = entry_name
		get_tree().change_scene_to_packed.call_deferred(room)
	else:
		print("Room not registered: "+room_name)
		

func get_entry():
	var entries = get_tree().get_nodes_in_group("Entry")
	for entry in entries:
		if entry is EntryTrigger:
			if entry.entry_name == current_entry_name:
				return entry
				
	return null
	
	
