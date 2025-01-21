class_name Possessable extends Node2D

@export var sprite : Sprite2D

#@onready var interaction_area: InteractionArea = $InteractionArea
#@onready var animation_player: AnimationPlayer = $AnimationPlayer
#@onready var collision_shape: CollisionShape2D = $Hurtbox/CollisionShape2D

const GHOST_BURST_PARTICLES = preload("res://player/ghost_burst_particles.tscn")

var can_be_possessed = true
var can_be_unpossessed = false
var unpossess_delay = 0.2
var is_possessed = false
var z_pos: float = 0

#func _ready() -> void:
	#interaction_area.interact = Callable(self, "_on_interact")
	#collision_shape.disabled = true
	#$Hurtbox.hit.connect($BreakComponent.on_break)
	
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
		
		var anim_possess: Animation = $AnimationPlayer.get_animation("possession")
		anim_possess.track_set_path(0, "../Sprite2D:position")
		anim_possess.track_set_path(2, "../Sprite2D:rotation")
		$AnimationPlayer.play("possession")
		
		can_be_unpossessed = false
		can_be_possessed = false
		#interaction_area.is_interactable = false
		await get_tree().create_timer(unpossess_delay).timeout
		can_be_unpossessed = true
		z_pos = -100
		is_possessed = true


#func _on_interact():
	#var player = get_tree().get_first_node_in_group("Player")
	#if player:
		#_on_get_possessed(player)

#func _on_get_possessed(player: Player):
	#if can_be_possessed:
		#var particles = GHOST_BURST_PARTICLES.instantiate()
		#particles.global_position = player.global_position
		#get_parent().add_child(particles)
		#player.global_position = global_position
		##player.on_possess(self)
		#reparent(player)
		#animation_player.play("possession")
		#can_be_unpossessed = false
		#can_be_possessed = false
		#interaction_area.is_interactable = false
		#await get_tree().create_timer(unpossess_delay).timeout
		#can_be_unpossessed = true
		#z_pos = -100
		#is_possessed = true

func _on_unpossess():
	var anim_possess: Animation = $AnimationPlayer.get_animation("possession")
	anim_possess.track_set_path(0, "../Sprite2D:position")
	anim_possess.track_set_path(2, "../Sprite2D:rotation")
	$AnimationPlayer.play_backwards("possession")
	can_be_possessed = true
	is_possessed = false
	SignalBuss.possessed.emit(false)
	get_parent().reparent(get_tree().get_first_node_in_group("MainLayer"))
	
func on_attack():
	pass
	

func play_possession_idle():
	var anim: Animation = $AnimationPlayer.get_animation("idle")
	anim.track_set_path(0, "../Sprite2D:rotation")
	$AnimationPlayer.play("idle")
	
