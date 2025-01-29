extends Button

@export var texture : Texture2D
@export var texture_focus : Texture2D

const ROOM_ENTRY = preload("res://rooms/room_entry.tscn")

func _ready() -> void:
	mouse_entered.connect(on_mouse_entered)
	mouse_exited.connect(on_mouse_exited)
	focus_entered.connect(on_mouse_entered)
	focus_exited.connect(on_mouse_exited)


func on_mouse_entered():
	icon = texture_focus


func on_mouse_exited():
	icon = texture


func _pressed() -> void:
	get_tree().change_scene_to_packed.call_deferred(ROOM_ENTRY)
