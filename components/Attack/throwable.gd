class_name Throwable extends AttackAction

@export var throw_speed := 700
@export var hurtbox : HurtBox
@export var sprite : Sprite2D
@export var velocity_component : VelocityComponent

const GRAVITY := 9.8
var velocity : Vector3 = Vector3()
var z_pos : float = 0.0
var apply_gravity = true

signal thrown

func attack(callback: Callable):
	throw_at_mouse()
	
	callback.call()

func _physics_process(delta: float):
	get_parent().rotation_degrees += velocity_component.velocity3.length()*delta
		

func throw_at_mouse():
	throw_at(get_global_mouse_position())

func throw_at(target: Vector2):
	var angle = global_position.angle_to_point(target)
	if hurtbox:
		hurtbox.collision_shape.disabled = false
	var vel = Vector2.RIGHT.rotated(angle)*throw_speed
	velocity_component.z_pos = -1
	velocity_component.set_velocity3D(Vector3(vel.x, vel.y, get_launch_vel(target)))
	thrown.emit()
	

func get_launch_vel(target: Vector2):
	var distance = global_position.distance_to(target)
	var steps = distance / (throw_speed*get_process_delta_time())
	return steps * -GRAVITY*0.5
