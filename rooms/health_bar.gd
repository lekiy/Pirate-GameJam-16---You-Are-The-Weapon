extends ProgressBar

func _ready() -> void:
	SignalBuss.health_changed.connect(update_health_bar)

func update_health_bar(new_max_value: float, current_value: float):
	value = current_value
	max_value = new_max_value
