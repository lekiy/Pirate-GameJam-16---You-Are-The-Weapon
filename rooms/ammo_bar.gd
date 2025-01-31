extends Node2D

const AMMO_UI = preload("res://rooms/Menu/ammo_ui.tscn")

func _ready() -> void:
	SignalBuss.ammo_changed.connect(on_ammo_changed)


func on_ammo_changed(max_ammo: float, current_ammo: float, ammo_texture: Texture2D, custom_textures):
	for ammo in get_children():
		ammo.queue_free()
		
	for i in current_ammo:
		var ammo = AMMO_UI.instantiate()
		var step = $"../HealthBar".size.x/max_ammo*3.5
		if custom_textures and custom_textures.size() > 0:
			ammo.texture = custom_textures[i]
		else:
			ammo.texture = ammo_texture
		ammo.position = Vector2(i*step, 0)
		add_child(ammo)
	
	
	
