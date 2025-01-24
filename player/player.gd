class_name Player extends CharacterBody2D

@onready var sprite: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

const SPEED = 600.0

func _ready() -> void:
	animation_player.play("hover")
	SignalBuss.possessed.connect(on_possess)
	$HealthComponent.health_changed.connect(on_player_health_changed)
	on_enter_room()

func on_enter_room():
	on_player_health_changed($HealthComponent.MAX_HEALTH, $HealthComponent.health)

func _physics_process(delta: float) -> void:
	handle_movement()
	
					
func handle_movement():
	var move_direction = Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_up", "move_down")).normalized()
	
	velocity = move_direction*SPEED
	move_and_slide()

	if velocity.x > 0:
		$Sprite2D.flip_h = true
	else:
		$Sprite2D.flip_h = false
		

func on_possess(value):
	if value:
		sprite.visible = false
	else:
		on_unpossess()
	
	
func on_unpossess():
	sprite.visible = true
	$InteractionManager.can_interact = true 

func on_player_health_changed(new_max_value, new_value):
	SignalBuss.health_changed.emit(new_max_value, new_value)
