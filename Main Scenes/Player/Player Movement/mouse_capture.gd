extends State
class_name mouse_capture

@export var fall_state: State
@export var jump_state: State
@export var move_state: State
@export var idle_state: State

func enter() -> void:
	super()
	
func process_input(event: InputEvent) -> State:
	# Mouse look
	if event is InputEventMouseMotion:
		# Look left / right
		parent.rotation_degrees.y -= event.relative.x * parent.sensitivity
		
		# Look up / down
		parent.kamera.rotation_degrees.x -= event.relative.y * parent.sensitivity
		parent.kamera.rotation_degrees.x = clamp(parent.kamera.rotation_degrees.x, -80.0, 80.0)
		
	# Escape key: show mouse
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	# Left click: hide mouse
	elif event.is_action_pressed("left_click"):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	# Animation for left click
	if Input.is_action_just_pressed("left_click"):
		parent.animations.play("pew")
	else:
		parent.animations.play("idle")
		
	return null
