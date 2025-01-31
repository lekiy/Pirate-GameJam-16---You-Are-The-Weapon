extends Node2D

var ammo_ui = []
const AMMO_UI = preload("res://rooms/Menu/ammo_ui.tscn")

func _ready() -> void:
	SignalBuss.ammo_changed.connect(on_ammo_changed)


func on_ammo_changed(max_ammo: float, current_ammo: float, ammo_texture: Texture2D):
	for ammo in get_children():
		ammo.queue_free()
		
	for i in current_ammo:
		var ammo = AMMO_UI.instantiate()
		var step = $"../HealthBar".size.x/max_ammo*3.5
		ammo.texture = ammo_texture
		ammo.position = Vector2(i*step, 0)
		add_child(ammo)
	
	
	
