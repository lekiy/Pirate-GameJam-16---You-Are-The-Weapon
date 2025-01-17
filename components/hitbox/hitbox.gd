class_name Hitbox extends Area2D

var health_component : HealthComponent

func _ready():
	load_component()
			
func load_component():
	var nodes = get_parent().get_children()
	for node in nodes:
		if node is HealthComponent:
			health_component = node
			return
			
	print("Health Component Missing on load")
	

func damage(attack: Attack):
	if health_component:
		health_component.damage(attack)
