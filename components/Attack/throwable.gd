class_name Throwable extends AttackAction

@export var throw_speed := 700
@export var hurtbox : HurtBox
@export var sprite : Sprite2D


const GRAVITY := 9.8
var velocity : Vector3 = Vector3()
var z_pos : float = 0.0
var apply_gravity = true

signal thrown

func attack(callback: Callable):
	throw_at_mouse()
	
	callback.call()

func _physics_process(delta: float):
	if z_pos < 0:
		if apply_gravity:
			velocity.z += GRAVITY
	else:
		if velocity.z > 50:
			if hurtbox:
				hurtbox.hit.emit()
				
		else:
			velocity.z = -velocity.z
		velocity *= 0.8
	
	if sprite:
		sprite.rotation_degrees += Vector2(velocity.x, velocity.y).length()*delta
	z_pos += velocity.z*delta
	get_parent().global_position += Vector2(velocity.x, velocity.y + velocity.z)*delta


func throw_at_mouse():
	throw_at(get_global_mouse_position())

func throw_at(target: Vector2):
	var angle = global_position.angle_to_point(target)
	if hurtbox:
		hurtbox.collision_shape.disabled = false
	var vel = Vector2.RIGHT.rotated(angle)*throw_speed
	z_pos = -1
	velocity.x = vel.x
	velocity.y = vel.y
	velocity.z = get_launch_vel(target)
	thrown.emit()
	

func get_launch_vel(target: Vector2):
	var distance = global_position.distance_to(target)
	var steps = distance / (throw_speed*get_process_delta_time())
	return steps * -GRAVITY*0.5
