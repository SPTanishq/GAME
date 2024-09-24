class_name CardStateMachine
extends Node

@export var initial_state: CardState

var current_state: CardState
var states: Dictionary = {}


func _ready():
	for child in get_children():
		if child is CardState:
			states[child.name.to_lower()] = child
			child.transitioned.connect(on_child_transition)

	print(states)
	
	if initial_state:
		initial_state.call_deferred("_enter")
		current_state = initial_state


func on_input(event: InputEvent):
	if current_state:
		current_state.on_input(event)


func on_gui_input(event: InputEvent):
	if current_state:
		current_state.on_gui_input(event)


func on_mouse_entered():
	if current_state:
		current_state.on_mouse_entered()


func on_mouse_exited():
	if current_state:
		current_state.on_mouse_exited()


func on_child_transition(new_state_name): #connected to transioned signal
	var new_state: CardState = states.get(new_state_name.to_lower())
	if !new_state:
		prints(current_state, "transition to no state")
		return
	
	if current_state:
		current_state._exit()
	new_state.call_deferred("_enter")
	current_state = new_state
