class_name SoundComponent extends Node2D

@export var sounds : Array[AudioStreamWAV]
	
func play():
	var sound = AudioStreamPlayer.new()
	sound.finished.connect(sound.queue_free)
	sound.stream = sounds.pick_random()
	sound.pitch_scale = randf_range(0.9, 1.1)
	sound.bus = "Effects"
	get_tree().get_first_node_in_group("MainLayer").add_child(sound)
	sound.play()
	
