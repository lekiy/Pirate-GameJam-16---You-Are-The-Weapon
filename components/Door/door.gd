class_name EntryTrigger extends Area2D

@export var entry_name: String = "south_east"
@export var target_entry_name: String = "north_east"
@export var room_name: String = "room_test"
@export var target_room_name: = "room_test" 

@export var entry_point: Marker2D

var locked = false

func _ready() -> void:
	area_entered.connect(on_area_entered)
	
func _process(delta: float) -> void:
	if RoomController.locked:
		if not locked:
			$AnimationPlayer.play("apply_flame")
			locked = true
	else:
		if locked:
			$AnimationPlayer.play_backwards("apply_flame")
			locked = false
		
	
func on_area_entered(area: Area2D):
	if area.get_parent() is Player:
		RoomController.move_to_room(target_room_name, target_entry_name)
