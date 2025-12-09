extends State

@export var fall_state: State
@export var idle_state: State
@export var move_state: State

func enter() -> void:
	super()
	parent.velocity.y = parent.jump_force

func process_physics(delta: float) -> State:
	parent.velocity.y -= gravity * delta

	if Input.is_action_just_released("jump") and parent.velocity.y > 0.0:
		parent.velocity.y -= 4.0

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

	# Check if falling AFTER move_and_slide completes
	if parent.velocity.y < 0.0:
		return fall_state

	return null
