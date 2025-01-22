extends Node2D

@export var initial_state : State

var current_state : State
var states : Dictionary = {}

func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.transitioned.connect(on_child_transition)
	
	if initial_state:
		initial_state.state_enter()
		current_state = initial_state

func _process(delta: float) -> void:
	if current_state: 
		current_state.state_process(delta)
		#$Label.text = current_state.name
		

func _physics_process(delta: float) -> void:
	if current_state: 
		current_state.state_physics_process(delta)

func on_child_transition(state, new_state_name):
	if state != current_state:
		return
		
	var new_state = states.get(new_state_name.to_lower())
	
	current_state.state_exit()
	new_state.state_enter()
	current_state = new_state
