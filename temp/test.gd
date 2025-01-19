extends Node2D

var velocity = Vector2.ZERO
var gravity = 9.8
var speed = 400
@onready var sprite = $Sprite2D

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("attack"):
		sprite.global_position = Vector2.ZERO
		velocity = Vector2.ZERO
		velocity.x = speed
		velocity.y = get_launch_speed()
		$Label.text = str(get_launch_speed())
		
	velocity.y += gravity
	
	sprite.global_position += velocity*delta

func get_launch_speed():
	var x_dif = get_global_mouse_position().x - 0
	var y_dif = get_global_mouse_position().y - 0
	var steps = x_dif / (speed*get_process_delta_time())
	return steps * -gravity*0.5 + y_dif
