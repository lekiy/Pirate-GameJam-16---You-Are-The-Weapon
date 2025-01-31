class_name Shootable extends AttackAction

const BULLET_SCENE = preload("res://components/Projectile/bullet.tscn")
@export var ammo: Ammo
@export var bullet_spawn_point: Marker2D
var custom_textures

var current_ammo
signal fire

func _ready() -> void:
	current_ammo = ammo.amount

func attack(callback: Callable):
	if ammo:
		if current_ammo > 0 or ammo.amount == -1:
			if custom_textures and custom_textures.size() > 0:
				ammo.texture = custom_textures[current_ammo-1]
			
			var bullet = BULLET_SCENE.instantiate()
			if bullet_spawn_point:
				bullet.global_position = bullet_spawn_point.global_position
			else: 
				bullet.global_position = global_position
			
			var angle = randf_range(-ammo.spread, ammo.spread)
			var bullet_direction = bullet.global_position.direction_to(get_global_mouse_position()).rotated(deg_to_rad(angle))
			bullet.velocity = bullet_direction *ammo.speed
			
			bullet.ammo = ammo
			
			var layer = get_tree().get_first_node_in_group("MainLayer")
			layer.add_child(bullet)
			current_ammo -= 1
			SignalBuss.ammo_changed.emit(ammo.amount, current_ammo, ammo.texture, custom_textures)
			fire.emit()
			await get_tree().create_timer(ammo.fire_rate).timeout

func on_possessed():
	SignalBuss.ammo_changed.emit(ammo.amount, current_ammo, ammo.texture, custom_textures)
	
	
func on_unpossessed():
	SignalBuss.ammo_changed.emit(0, 0, ammo.texture, custom_textures)
