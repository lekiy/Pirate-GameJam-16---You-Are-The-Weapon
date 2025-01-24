extends Node2D

@export var sprite: Sprite2D

func _ready() -> void:
	$GPUParticles2D.texture = sprite.texture

func on_break():
	var break_position = get_parent().global_position
	var layer = get_tree().get_first_node_in_group("MainLayer")
	get_parent().remove_child(self)
	layer.add_child(self)
	global_position = break_position
	$AnimationPlayer.play("default")
