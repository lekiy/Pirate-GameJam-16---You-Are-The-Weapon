class_name Possessable extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var animation_player: AnimationPlayer = $AnimationPlayer


var can_be_possessed = true
var can_be_unpossessed = false
var unpossess_delay = 0.2
var speed = 1100
var velocity = Vector2.ZERO

@onready var collision_shape: CollisionShape2D = $Hurtbox/CollisionShape2D


func _ready() -> void:
	interaction_area.interact = Callable(self, "_on_interact")
	collision_shape.disabled = true
	
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
		animation_player.play("possession")
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
	collision_shape.disabled = false
	animation_player.play("Throw")
	velocity = Vector2.RIGHT.rotated(angle)*speed
	
func play_possession_idle():
	animation_player.play("idle")
