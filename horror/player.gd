extends CharacterBody3D

var sensitivity: float = 0.3
var limitKamera: float = 80.0

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		# Beweeg links en regs
		rotation_degrees.y -= event.relative.x * sensitivity
		#Beweeg op en af
		%Camera3D.rotation_degrees.x -= event.relative.y * sensitivity
		#Limit Kamera sodat dit nie te ver op/af kyk nie
		%Camera3D.rotation_degrees.x = clamp(
			%Camera3D.rotation_degrees.x, -limitKamera, limitKamera
			)
	# As dit inset kry van iets anders as die muis, bv. Keyboard
	#UI_CANCEL is built in key... ESC
	elif event.is_action_pressed("ui_cancel"):
		pass
