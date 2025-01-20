class_name InteractionManager extends Area2D

var active_areas = []
var can_interact = true

func _ready() -> void:
	area_entered.connect(_register_area)
	area_exited.connect(_unregister_area)

func _process(delta: float) -> void:
	if active_areas.size() > 0:
		active_areas.sort_custom(sort_areas_by_distance)
		var index = 0
		for area in active_areas:
			if index == 0:
				area.toggle_outline(true)
			else:
				area.toggle_outline(false)
			index += 1
			
		
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		if active_areas.size() > 0 and can_interact:
			can_interact = false
			
			await active_areas[0].interact.call()
			can_interact = true
			

func _register_area(area: Area2D):
	if area is InteractionArea:
		active_areas.push_back(area)
	
func _unregister_area(area: Area2D):
	if area is InteractionArea:
		var index = active_areas.find(area)
		if index != -1:
			active_areas[index].toggle_outline(false)
			active_areas.remove_at(index)

func sort_areas_by_distance(area1, area2):
	var dist1 = global_position.distance_to(area1.global_position)
	var dist2 = global_position.distance_to(area2.global_position)
	return dist1 < dist2
