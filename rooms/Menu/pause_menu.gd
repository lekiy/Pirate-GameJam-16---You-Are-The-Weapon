extends CanvasLayer

var paused = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		set_paused(not paused)

func set_paused(value):
	get_tree().paused = value
	visible = value
	paused = value
	
