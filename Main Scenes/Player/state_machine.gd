extends Node

@export 
var starting_state: State

var current_state: State

#Initisialize machine, kind kry refrence na parent
func init(parent: Player) -> void:
	for child in get_children():
		child.parent = parent
		
	# Default state
	change_state(starting_state)
	
# Kyk of ons 'n nuwe state moet kry, anders exit
func change_state(new_state: State) -> void:
	if current_state:
		current_state.exit()
	
	current_state = new_state
	current_state.enter()
	
#Hanteer veranderinge in states
func process_input(event: InputEvent) -> void:
	var new_state = current_state.process_input(event)
	if new_state:
		change_state(new_state)
		
func process_frame(delta: float) -> void:
	var new_state = current_state.process_frame(delta)
	if new_state:
		change_state(new_state)
