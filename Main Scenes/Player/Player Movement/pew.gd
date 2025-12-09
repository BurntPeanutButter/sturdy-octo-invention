extends State

@export var idle_state: State
@export var move_state: State

func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed("left_click"):
		parent.animations.play("pew")
	return null

func process_physics(delta: float) -> State:
	if parent.input_dir_3d != Vector3.ZERO:
		parent.animations.play("idle")
		return move_state
	return null
