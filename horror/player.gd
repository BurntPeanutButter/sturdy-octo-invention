extends CharacterBody3D

var speed: float = 500.0

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.relative.x * 0.3
		#get_node(Camera3D) Main
		# $Camera3D -> Shortcut
		%Camera3D.rotation_degrees.x -= event.relative.y * 0.1# Right Click Kamera dan Unique name
		#%gun_model # Omdat unique is dit nie meer #Camera3D/gun_model
		%Camera3D.rotation_degrees.x = clamp(
			%Camera3D.rotation_degrees.x, -80.0, 80.0
			)
	# As dit inset kry van iets anders as die muis, bv. Keyboard
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
