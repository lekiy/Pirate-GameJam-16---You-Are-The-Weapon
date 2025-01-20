class_name InteractionArea extends Area2D

const OUTLINE_MATERIAL = preload("res://player/outline_material.tres")
@export var sprite_ref: Sprite2D

var interact: Callable = func():
	pass

var is_interactable = true

func on_interact():
	pass
	
func toggle_outline(outline):
	if outline:
		sprite_ref.material = OUTLINE_MATERIAL
	else:
		sprite_ref.material = null
	
