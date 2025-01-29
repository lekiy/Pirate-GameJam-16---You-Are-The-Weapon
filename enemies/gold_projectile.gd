class_name GoldProjectile extends HurtBox

var spell_origin : Marker2D
const GOLD_BURST_PARTICLE = preload("res://enemies/gold_burst_particle.tscn")
func _ready() -> void:
	super()
	$BurstTimer.timeout.connect(on_burst)


func on_burst():
	if is_instance_valid(spell_origin):
		$CollisionShape2D.disabled = false
		$Line2D.visible = true
		$Line2D.add_point(Vector2.ZERO)
		$Line2D.add_point(spell_origin.global_position - global_position)
		var particle = GOLD_BURST_PARTICLE.instantiate()
		particle.global_position = global_position
		particle.emitting = true
		get_tree().get_first_node_in_group("MainLayer").add_child(particle)
		await get_tree().create_timer(0.1).timeout
		queue_free()
