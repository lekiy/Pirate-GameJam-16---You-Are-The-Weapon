extends Sprite2D

const OUTLINE_MATERIAL = preload("res://player/outline_material.tres")

@export var outline_enabled = false

func _process(delta: float) -> void:
	if outline_enabled:
		material = OUTLINE_MATERIAL
	else:
		material = null
	
