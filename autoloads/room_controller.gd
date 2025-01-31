extends Node

const ROOM_TEST = preload("res://rooms/RoomTest.tscn")
const ROOM_ENTRY = preload("res://rooms/room_entry.tscn")
const ROOM_LIVING = preload("res://rooms/room_living.tscn")
const ROOM_LIBRARY = preload("res://rooms/room_library.tscn")
const ROOM_KITCHEN = preload("res://rooms/room_kitchen.tscn")
const ROOM_SECRIT = preload("res://rooms/room_secrit.tscn")
const ROOM_STUDY = preload("res://rooms/room_study.tscn")
const ROOM_BED = preload("res://rooms/room_bed.tscn")

const LOSE_SCREEN = preload("res://rooms/Menu/LoseScreen.tscn")
const WIN_SCREEN = preload("res://rooms/Menu/WinScreen.tscn")

var player: Player
var spawn_position : Vector2 = Vector2.ZERO
var current_room_name: String
var current_entry_name: String

var locked = false
var ingredients_collected : Array[Ingredient] = []
var book_discovered := false
var in_combat := false
var paused = false

var room_dict = {
	"room_test": ROOM_TEST,
	"room_entry": ROOM_ENTRY,
	"room_living": ROOM_LIVING,
	"room_library": ROOM_LIBRARY,
	"room_kitchen": ROOM_KITCHEN,
	"room_secrit": ROOM_SECRIT,
	"room_study": ROOM_STUDY,
	"room_bed": ROOM_BED,
}

func _ready() -> void:
	SignalBuss.game_over.connect(game_lost)


func game_lost():
	await get_tree().create_timer(3).timeout
	get_tree().change_scene_to_packed(LOSE_SCREEN)


func game_won():
	await get_tree().create_timer(1).timeout
	ingredients_collected = []
	get_tree().change_scene_to_packed(WIN_SCREEN)
	

func add_ingredient(ingredient: Ingredient):
	if not ingredients_collected.has(ingredient):
		ingredients_collected.push_back(ingredient)
		return true
		
	return false


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Reset"):
		get_tree().reload_current_scene()
		
	if get_tree().get_nodes_in_group("Enemy").size() > 0 or not book_discovered:
		locked = true
	else:
		locked = false
	
	check_combat()
	
	if ingredients_collected.size() >= 4:
		game_won()
		
		
func check_combat():
	if get_tree().get_nodes_in_group("Enemy").size() > 0:
		if not MusicPlayer.battle_active:
			MusicPlayer.transition.emit(true)
	else:
		if MusicPlayer.battle_active:
			MusicPlayer.transition.emit(false)
		in_combat = false


func move_to_room(room_name, entry_name):
	print("moving to room "+str(room_name)+" at entry "+str(entry_name))
	in_combat = false
	MusicPlayer.battle_active = false
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
	

	
