class_name VelocityComponent extends Node2D

@onready var body : CharacterBody2D = get_parent()

@export var ground_friction := 0.8
@export var apply_gravity = true
const GRAVITY := 9.8

var velocity3 : Vector3 = Vector3()
var z_pos : float
var on_ground = false


func _physics_process(delta: float) -> void:
	if z_pos < 0:
		if apply_gravity:
			velocity3.z += GRAVITY
			on_ground = false
	else:
		on_ground = true
		velocity3.z = 0
		z_pos = 0
		velocity3 *= ground_friction
	
	move(delta)
	
func move(delta: float):
	z_pos += velocity3.z*delta
	body.global_position += Vector2(velocity3.x, velocity3.y + velocity3.z)*delta
	
	body.move_and_slide()

func set_velocity(velocity: Vector2):
	velocity3 = Vector3(velocity.x, velocity.y, 0)
	
func set_velocity3D(velocity: Vector3):
	velocity3 = velocity
