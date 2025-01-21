class_name HurtBox extends Area2D

@export var attack_damage := 10



signal hit

func _ready() -> void:
	area_entered.connect(on_hitbox_area_entered)
	hit.connect(on_hit)

func on_hitbox_area_entered(area: Area2D):
	if area is Hitbox:
		var attack = Attack.new()
		attack.attack_damage = attack_damage
		hit.emit()
		area.damage(attack)
		
func on_hit():
	get_parent().queue_free()
	
