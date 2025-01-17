extends Area2D

@export var attack_damage := 10

func _ready() -> void:
	area_entered.connect(on_hitbox_area_entered)

func on_hitbox_area_entered(area: Area2D):
	if area is Hitbox:
		var attack = Attack.new()
		attack.attack_damage = attack_damage
		
		area.damage(attack)
		get_parent().queue_free()
