class_name Telegraph extends Node2D

@export var duration := 1.0
@export var direction := Vector2()

func _ready() -> void:
	$Timer.timeout.connect(queue_free)
	$Timer.wait_time = duration
	$Sprite2D.rotation = direction.angle()-deg_to_rad(90.0)
