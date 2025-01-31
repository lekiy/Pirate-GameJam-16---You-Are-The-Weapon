class_name Player extends CharacterBody2D

@onready var sprite: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
const GHOST_BURST_PARTICLES = preload("res://player/ghost_burst_particles.tscn")

const SPEED = 600.0

var possessing = false

func _ready() -> void:
	animation_player.play("hover")
	SignalBuss.possessed.connect(on_possess)
	$HealthComponent.health_changed.connect(on_player_health_changed)
	on_enter_room()
	
	$HealthComponent.died.connect(on_death)
	$Hitbox.hit.connect(on_hit)
		
func on_death():
	var particle = GHOST_BURST_PARTICLES.instantiate()
	particle.global_position = global_position
	get_parent().add_child(particle)
	
func on_hit():
	$HitFlash.play("hitflash")

func on_enter_room():
	on_player_health_changed($HealthComponent.MAX_HEALTH, $HealthComponent.health)

func _physics_process(delta: float) -> void:
	handle_movement()
	
	$Node2D/PossessingSprite.rotation_degrees -= 360*delta
	
					
func handle_movement():
	var move_direction = Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_up", "move_down")).normalized()
	
	velocity = move_direction*SPEED
	move_and_slide()

	if move_direction.x > 0:
		$Sprite2D.scale.x = -1
	else:
		$Sprite2D.scale.x = 1
		

func on_possess(value):
	if value:
		sprite.visible = false
		$Node2D/PossessingSprite.visible = true
		$AudioStreamPlayer.play()
	else:
		$AudioStreamPlayer2.play()
		on_unpossess()
	
	
func on_unpossess():
	sprite.visible = true
	$Node2D/PossessingSprite.visible = false
	$InteractionManager.can_interact = true 

func on_player_health_changed(new_max_value, new_value):
	SignalBuss.health_changed.emit(new_max_value, new_value)
