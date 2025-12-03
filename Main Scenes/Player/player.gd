extends CharacterBody3D

var speed: float = 500.0
var sensitivity: float = 0.4

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$Kop/AnimationPlayer.play("head_bob")

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		#kyk links en regs
		rotation_degrees.y -= event.relative.x * sensitivity
		
		#Kyk op en af
		%Camera3D.rotation_degrees.x -= event.relative.y * sensitivity# Right Click Kamera dan Unique name
		#%gun_model # Omdat unique is dit nie meer #Camera3D/gun_model
		#Maak seker ons kan nie te ver op en af kyk nie
		%Camera3D.rotation_degrees.x = clamp(
			%Camera3D.rotation_degrees.x, -80.0, 80.0
			)
	# If "escape key" = Kan muis sien
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	# If "left click" = Kan muis nie meer sien nie
	elif event.is_action_pressed("left_click"):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _physics_process(delta: float) -> void:
	const SPEED: float = 5.5
	
	var input_direction_2D = Input.get_vector(
		#move left and right = beweeg -x of +x
		#move forward and backward = beweeg -y of +y
		"move_left", "move_right", "move_forward", "move_backward"
	)
	
	# Wys grond beweeging
	var input_direction_3D = Vector3(
		# Beweeg x
		input_direction_2D.x,
		# Beweeg nie y
		0.0,
		# Beweeg z
		input_direction_2D.y
	)
	
	#transform Orientation sodat hy nie net z en x in een rigting vat nie
	#Basis is vir X Y Z 
	var direction = transform.basis * input_direction_3D
	#Beweeg x
	
	velocity.x = direction.x * SPEED
		
	var viewBobSpoed: float = 1.0
	if velocity.x or velocity.z > 0:
		if $Kop/AnimationPlayer	.speed_scale != viewBobSpoed:
			$Kop/AnimationPlayer.speed_scale = viewBobSpoed
	elif velocity.x or velocity.z == 0:
		if $Kop/AnimationPlayer	.speed_scale != 0.0:
			$Kop/AnimationPlayer.speed_scale = 0.0
	#Beweeg z
	velocity.z = direction.z * SPEED
	
	#Gravity
	velocity.y -= 20.0 * delta
	#Soek spring key dan gaan op en moet op grond wees
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = 10.0
		#Hou spacebar in, gaan hoer
	elif Input.is_action_just_released("jump") and velocity.y > 0.0:
		velocity.y = 0
	#Laat toe dat dude kan beweeg met built in metode
	move_and_slide()
