class_name Possessable extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea


var can_be_possessed = true
var can_be_unpossessed = false
var unpossess_delay = 0.2
var speed = 900
var velocity = Vector2.ZERO

func _ready() -> void:
	interaction_area.interact = Callable(self, "_on_interact")
	
func _physics_process(delta: float):
	global_position += velocity*delta
	
	
	
func _on_interact():
	var player = get_tree().get_first_node_in_group("Player")
	if player:
		_on_get_possessed(player)

func _on_get_possessed(player: Player):
	if can_be_possessed:
		player.global_position = global_position
		player.on_possess(self)
		reparent(player)
		can_be_unpossessed = false
		can_be_possessed = false
		interaction_area.is_interactable = false
		await get_tree().create_timer(unpossess_delay).timeout
		can_be_unpossessed = true

func _on_unpossess():
	interaction_area.is_interactable = true
	can_be_possessed = true
	
func on_attack():
	var target = get_global_mouse_position()
	var angle = global_position.angle_to_point(target)
	velocity = Vector2.RIGHT.rotated(angle)*speed
	
	
