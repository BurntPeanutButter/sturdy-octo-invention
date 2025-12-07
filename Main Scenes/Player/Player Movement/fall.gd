extends State

@export var idle_state: State
@export var move_state: State

func process_physics(delta: float) -> State:
	parent.velocity.y -= gravity * delta

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

	if parent.is_on_floor():
		if direction != Vector3.ZERO:
			return move_state
		return idle_state

	return null
