class_name State
extends Node

@export var animation_name: String
@export var move_speed: float = 400

@export
var input_direction_2D = Input.get_vector(
		#move left and right = beweeg -x of +x
		#move forward and backward = beweeg -y of +y
		"move_left", "move_right", "move_forward", "move_backward"
	)
# Wys grond beweeging
@export
var input_direction_3D = Vector3(
		# Beweeg x
		input_direction_2D.x,
		# Beweeg nie y
		0.0,
		# Beweeg z
		input_direction_2D.y
	)

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

#Beheer player
var parent: Player

func enter() -> void:
	parent.animations.play(animation_name)
	
func exit() -> void:
	pass
	
	#Null -> default
func process_input(event: InputEvent) -> State:
	return null
	
func process_frame(delta: float) -> State:
	return null
	
func process_physics(delta: float) -> State:
	return null
