extends CharacterBody3D

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.relative.x * 0.75
		%Camera3D.rotation_degrees.x -= event.relative.y * 0.75
		%Camera3D.rotation_degrees.x = clamp(
			%Camera3D.rotation_degrees.x, -80.0, 80.0
		)
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	elif event.is_action_pressed("left_click"):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	#Local Constants
	const SPEED_WALK = 1.5
	const SPEED_JOG = 6
	const SPEED_RUN = 10
	
	#Local Variables
	var speed
	var input_direction_2D = Input.get_vector(
		"move_left", "move_right", "move_forward", "move_backward"
	)
	var input_direction_3D = Vector3(
		input_direction_2D.x, 0.0, input_direction_2D.y
	)
	var direction = transform.basis * input_direction_3D
	
	#Directional ground movement
	if Input.is_action_pressed("Sprint"):
		speed = SPEED_RUN
	elif Input.is_action_pressed("Walk"):
		speed = SPEED_WALK
	else:
		speed = SPEED_JOG
	
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	
	#Jump Code
	velocity.y -= 20.0 * delta
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = 10
	elif Input.is_action_just_released("jump") and velocity.y > 0.0:
		velocity.y = 0
	
	move_and_slide()
