extends CharacterBody3D

@export var look_sensitivity: float = 0.003
@export var jump_velocity := 6.0
@export var auto_bhop := true
@export var walk_speed := 7.0

var wish_dir := Vector3.ZERO

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	elif event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			rotate_y(-event.relative.x * look_sensitivity)
			%Camera3D.rotate_x(-event.relative.y * look_sensitivity)
			%Camera3D.rotation.x = clamp(%Camera3D.rotation.x, deg_to_rad(-90), deg_to_rad(90))

func _handle_air_physics(delta) -> void:
	self.velocity.y -= ProjectSettings.get_setting("physics/3d/default_gravity") * delta

func _handle_ground_physics(delta) -> void:
	self.velocity.x = wish_dir.x * walk_speed
	self.velocity.z = wish_dir.z * walk_speed

func _physics_process(delta):
	var input_dir = Input.get_vector("right", "left", "down", "up").normalized()
	wish_dir = self.global_transform.basis * Vector3(-input_dir.x, 0., -input_dir.y)
	
	if is_on_floor():
		_handle_ground_physics(delta)
	else:
		_handle_air_physics(delta)
	
	move_and_slide()
