extends State

@export var fall_state: State
@export var jump_state: State
@export var move_state: State
@export var pew_state: State

@export var friction: float = 5.0  # tweak this

func enter() -> void:
	super()
	

func process_physics(delta: float) -> State:
	parent.velocity.y -= gravity * delta
	
	parent.velocity.x = lerp(parent.velocity.x, 0.0, friction * delta)
	parent.velocity.z = lerp(parent.velocity.z, 0.0, friction * delta)

	if parent.input_dir_3d != Vector3.ZERO:
		parent.animations.play("idle")
		return move_state
	
	parent.move_and_slide()
	
	if !parent.is_on_floor():
		return fall_state
	
	return null

func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed("jump") and parent.is_on_floor():
		return jump_state
	elif Input.is_action_just_pressed("left_click"):
		return pew_state

	return null
