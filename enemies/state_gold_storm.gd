extends State

const GOLD_PROJECTILE = preload("res://enemies/GoldProjectile.tscn")

@export var body : EnemySecrit
@export var projectile_count := 7
@export var delay = 0.3
@export var spread := 100.0

var time = 0.0
var spawns = 0

var target

func state_enter():
	target = get_tree().get_first_node_in_group("Player")
	$"../../Marker2D/GPUParticles2D".emitting = true
	
func state_physics_process(delta: float):
	body.velocity = Vector2()

	if is_instance_valid(target):
		if spawns <= projectile_count:
			time += delta
			if time >= delay:
				time = 0.0
				spawn_gold()
		else:
			spawns = 0
			transitioned.emit(self, "StateIdle")
	else:
		transitioned.emit(self, "StateIdle")
	
func spawn_gold():
	var layer = get_tree().get_first_node_in_group("MainLayer")
	var projectile = GOLD_PROJECTILE.instantiate()
	await get_tree().create_timer(delay).timeout
	projectile.spell_origin = $"../../Marker2D"
	projectile.global_position = target.global_position + Vector2.UP.rotated(deg_to_rad(randf_range(0, 360)))*randf_range(0, spread)
	body.last_instance = projectile
	layer.add_child(projectile)
	spawns += 1
