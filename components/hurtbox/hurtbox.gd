class_name HurtBox extends Area2D

@export var attack_damage := 10
@export var knock_back := 2000
@export var destroy_on_collide : bool = false

@onready var collision_shape: CollisionShape2D = $CollisionShape2D


signal hit

func _ready() -> void:
	area_entered.connect(on_hitbox_area_entered)
	hit.connect(on_hit)

func on_hitbox_area_entered(area: Area2D):
	if area is Hitbox:
		var attack = Attack.new()
		attack.attack_damage = attack_damage
		area.damage(attack)
		if get_parent().velocity:
			area.knock_back_direction = get_parent().velocity.normalized()
			area.knock_back_force = knock_back
		hit.emit()

		
func on_hit():
	if destroy_on_collide:
		get_parent().queue_free()
	
