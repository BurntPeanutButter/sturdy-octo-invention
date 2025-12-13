class_name Interactable
extends StaticBody3D

signal interacted()

@export var prompt_message = "Interactable"
@export var prompt_action = "interact"

var input: InputEventKey = InputMap.action_get_events(prompt_action)[0] as InputEventKey
var keycode: int = DisplayServer.keyboard_get_keycode_from_physical(input.get_physical_keycode())
@export var key_name = OS.get_keycode_string(keycode)
#@export var key_name = 'E'

func get_prompt():
	return prompt_message + key_name
	
func interact(body):
	emit_signal("interacted")
