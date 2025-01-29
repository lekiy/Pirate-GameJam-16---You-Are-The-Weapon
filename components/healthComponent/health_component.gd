class_name HealthComponent extends Node

@export var MAX_HEALTH : float = 10.0
@export var hurt_sound : SoundComponent
@export var death_sound : SoundComponent

var health : float

signal health_changed(max_value: float, current_value: float)

signal died

func _ready():
	health = MAX_HEALTH

func damage(attack: Attack):
	health -= attack.attack_damage
	
	health_changed.emit(MAX_HEALTH, health)
	if health <= 0:
		died.emit()
		get_parent().queue_free()
		if death_sound:
			death_sound.play()
	else:
		if hurt_sound:
			hurt_sound.play()
