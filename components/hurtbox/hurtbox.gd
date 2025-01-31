class_name HurtBox extends Area2D

@export var attack_damage := 10
@export var knock_back := 2000
@export var destroy_on_collide : bool = false
@export var velocity_component : VelocityComponent
@export var sound_component: SoundComponent

@onready var collision_shape: CollisionShape2D = $CollisionShape2D


signal hit

func _ready() -> void:
	area_entered.connect(on_hitbox_area_entered)
	hit.connect(on_hit)

func on_hitbox_area_entered(area: Area2D):
	if area is Hitbox:
		var attack = Attack.new()
		attack.attack_damage = attack_damage
		if velocity_component:
			area.knock_back_direction = Vector2(velocity_component.velocity3.x, velocity_component.velocity3.y).normalized()
			area.knock_back_force = knock_back
		else:
			area.knock_back_direction = global_position.direction_to(area.get_parent().global_position)
			area.knock_back_force = knock_back

		area.damage(attack)
		if sound_component:
			sound_component.play()
		hit.emit()

		
func on_hit():
	if destroy_on_collide:
		get_parent().queue_free()
	
