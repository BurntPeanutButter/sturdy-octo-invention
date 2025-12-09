extends State
class_name move

@export var fall_state: State
@export var idle_state: State
@export var jump_state: State

func enter() -> void:
	super()
	# Clear horizontal velocity when entering move state
	parent.velocity.x = 0
	parent.velocity.z = 0

func process_input(event: InputEvent) -> State:
	if event is InputEventKey:
		if Input.is_action_just_pressed("jump") and parent.is_on_floor():
			return jump_state
		elif Input.is_action_just_released("jump") and parent.velocity.y > 0.0:
			parent.velocity.y -= 0.0
	
	return null

func process_physics(delta: float) -> State:
	parent.velocity.y -= gravity * delta
	
	# Handle sprinting vs walkinga
	if Input.is_action_pressed("sprint"):
		parent.spoed = parent.SPOED_HARDLOOP
	else:
		parent.spoed = parent.SPOED_LOOP
	
	var direction: Vector3 = parent.input_dir_3d

	if direction != Vector3.ZERO:
		var target_x = direction.x * parent.spoed
		var target_z = direction.z * parent.spoed
		parent.velocity.x = lerp(parent.velocity.x, target_x, delta * parent.accel)
		parent.velocity.z = lerp(parent.velocity.z, target_z, delta * parent.accel)
	else:
		parent.velocity.x = lerp(parent.velocity.x, 0.0, delta * parent.friction)
		parent.velocity.z = lerp(parent.velocity.z, 0.0, delta * parent.friction)

	parent.move_and_slide()

	# Return to idle if no input and on ground
	if parent.input_dir_3d == Vector3.ZERO and parent.is_on_floor():
		return idle_state

	if !parent.is_on_floor() and parent.velocity.y < 0:
		return fall_state

	return null
