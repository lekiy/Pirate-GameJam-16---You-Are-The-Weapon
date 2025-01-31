extends HSlider

@export var bus_name: String
@onready var audio_stream_player: AudioStreamPlayer = $"../VolumeSlider2/AudioStreamPlayer"

var bus_index: int

func _ready() -> void:
	bus_index = AudioServer.get_bus_index(bus_name)
	value_changed.connect(on_value_changed)
	
func on_value_changed(new_value: float):
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(new_value))
	if audio_stream_player:
		audio_stream_player.play()
