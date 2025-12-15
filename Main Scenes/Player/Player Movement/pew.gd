extends State

@export var idle_state: State
@export var move_state: State

func enter() -> void:
	super()
	parent.animations.play("pew")

func process_input(event: InputEvent) -> State:
	return null

func process_physics(delta: float) -> State:
	#if !parent.animation == "pew":
	#	if parent.input_dir_3d != Vector3.ZERO:
	#		return move_state
	#		
	#	if parent.input_dir_3d == Vector3.ZERO and parent.is_on_floor():
	#		parent.animations.play("idle")
	return null
	
func _on_animation_player_animation_finished(animations) -> State:
	if !parent.animation == "pew":
		if parent.input_dir_3d == Vector3.ZERO and parent.is_on_floor():
			return idle_state
	if parent.input_dir_3d != Vector3.ZERO:
		return move_state
	return null
