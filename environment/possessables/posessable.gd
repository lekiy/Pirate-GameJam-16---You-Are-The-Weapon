class_name Possessable extends Node2D

@export var sprite : Sprite2D
@export var attack_action : AttackAction
@onready var interaction_area: InteractionArea = $"../InteractionArea"

const GHOST_BURST_PARTICLES = preload("res://player/ghost_burst_particles.tscn")

var can_be_possessed = true
var can_be_unpossessed = false
var unpossess_delay = 0.2
var is_possessed = false
var z_pos: float = 0
var can_attack = true

func _ready() -> void:
	interaction_area.interact = Callable(self, "_on_interact")

func _on_interact():
	var player = get_tree().get_first_node_in_group("Player")
	if player:
		possess(player)
	
func  _process(delta: float):
	if is_possessed:
		if Input.is_action_pressed("attack"):
			if attack_action and can_attack:
				can_attack = false
				await attack_action.attack(_on_unpossess_instant)
				can_attack = true
				
			
func possess(node: Node2D):
	if is_possessed:
		_on_unpossess()
	else:
		var particles = GHOST_BURST_PARTICLES.instantiate()
		particles.global_position = node.global_position
		var layer = get_tree().get_first_node_in_group("MainLayer")
		layer.add_child(particles)
			
		node.global_position = global_position
		SignalBuss.possessed.emit(true)
		get_parent().reparent(node)
		#
		#var anim_possess: Animation = $AnimationPlayer.get_animation("possession")
		#anim_possess.track_set_path(0, "../:position")
		#anim_possess.track_set_path(2, "../:rotation")
		#$AnimationPlayer.play("possession")
		
		can_be_unpossessed = false
		can_be_possessed = false
		#interaction_area.is_interactable = false
		await get_tree().create_timer(unpossess_delay).timeout
		can_be_unpossessed = true
		z_pos = -100
		is_possessed = true


func _on_unpossess():
	var anim_possess: Animation = $AnimationPlayer.get_animation("unpossess")
	anim_possess.track_set_path(0, "../Sprite2D:position")
	anim_possess.track_set_path(1, "../Sprite2D:rotation")
	$AnimationPlayer.play_backwards("unpossess")
	can_be_possessed = true
	is_possessed = false
	SignalBuss.possessed.emit(false)
	get_parent().reparent(get_tree().get_first_node_in_group("MainLayer"))

func _on_unpossess_instant():
	$AnimationPlayer.stop()
	can_be_possessed = true
	is_possessed = false
	SignalBuss.possessed.emit(false)
	get_parent().reparent(get_tree().get_first_node_in_group("MainLayer"))
	

func play_possession_idle():
	var anim: Animation = $AnimationPlayer.get_animation("idle")
	anim.track_set_path(0, "../Sprite2D:rotation")
	$AnimationPlayer.play("idle")
	
