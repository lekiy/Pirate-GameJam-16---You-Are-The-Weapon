class_name Possessable extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var collision_shape: CollisionShape2D = $Hurtbox/CollisionShape2D


var can_be_possessed = true
var can_be_unpossessed = false
var unpossess_delay = 0.2
var speed: float = 700
var velocity = Vector2.ZERO
var z_pos: float = 0
var z_vel: float = 0
const GRAVITY: float = 9.8
var is_possessed = false

func _ready() -> void:
	interaction_area.interact = Callable(self, "_on_interact")
	collision_shape.disabled = true
	$Hurtbox.hit.connect($BreakComponent.on_break)
	
func _physics_process(delta: float):
	$Label.text = str(get_launch_vel())
	if z_pos < 0:
		if not is_possessed:
			z_vel += GRAVITY
	else:
		if z_vel > 100:
			$Hurtbox.hit.emit()
		z_pos = 0
		z_vel = 0
		velocity *= 0.8
	
	z_pos += z_vel*delta
	global_position += Vector2(velocity.x, velocity.y + z_vel)*delta
	
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
		z_pos = -1
		is_possessed = true

func _on_unpossess():
	interaction_area.is_interactable = true
	can_be_possessed = true
	is_possessed = false
	
func on_attack():
	var target = get_global_mouse_position()
	var angle = global_position.angle_to_point(target)
	collision_shape.disabled = false
	animation_player.play("Throw")
	velocity = Vector2.RIGHT.rotated(angle)*speed
	z_vel = get_launch_vel()
	is_possessed = false
	
func get_launch_vel():
	var distance = global_position.distance_to(get_global_mouse_position())
	var steps = distance / (speed*get_process_delta_time())
	return steps * -GRAVITY*0.5

func play_possession_idle():
	animation_player.play("idle")
	
