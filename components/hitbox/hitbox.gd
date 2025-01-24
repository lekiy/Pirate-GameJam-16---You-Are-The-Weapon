class_name Hitbox extends Area2D

var health_component : HealthComponent
var knock_back_direction : Vector2 = Vector2()
var knock_back_force : float = 0.0

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
		
	if get_parent().has_method("knock_back"):
		get_parent().knock_back(knock_back_direction, knock_back_force)
