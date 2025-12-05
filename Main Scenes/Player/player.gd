extends CharacterBody3D

var spoed
const SPOED_LOOP: float = 5
const SPOED_HARDLOOP: float = 8
var sensitivity: float = 0.4
# Hoe vinnig kop op en af gaan
const BOB_FREQ = 2.0
# Hoe hoog en laag kop beweeg
const BOB_AMP = 0.08
# Sal kyk hoe ver ons op die golf is
var t_bob = 0.0


# Refrences from nodes need to be @onready
@onready var kop = $Kop
@onready var kamera = $Kop/Camera3D


func _ready() -> void:
	#Vang muis
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		#kyk links en regs
		rotation_degrees.y -= event.relative.x * sensitivity
		
		#Kyk op en af
		kamera.rotation_degrees.x -= event.relative.y * sensitivity# Right Click Kamera dan Unique name
		#%gun_model # Omdat unique is dit nie meer #Camera3D/gun_model
		#Maak seker ons kan nie te ver op en af kyk nie
		kamera.rotation_degrees.x = clamp(
			kamera.rotation_degrees.x, -80.0, 80.0
			)
	# If "escape key" = Kan muis sien
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	# If "left click" = Kan muis nie meer sien nie
	elif event.is_action_pressed("left_click"):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		
	if Input.is_action_pressed("left_click"):
		$Lyf/Arm/AnimationPlayer.play("ArmatureAction")
	else:
		$Lyf/Arm/AnimationPlayer.play("Idle")
		
	
func _physics_process(delta: float) -> void:
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
	
	#Hardloop en Loop
	if Input.is_action_pressed("Sprint"):
		spoed = SPOED_HARDLOOP
	else:
		spoed = SPOED_LOOP
	
	#transform Orientation sodat hy nie net z en x in een rigting vat nie
	#Basis is vir X Y Z 
	var direction = transform.basis * input_direction_3D
	
	if is_on_floor():
		if direction:
			#Beweeg x
			velocity.x = direction.x * spoed
			#Beweeg z
			velocity.z = direction.z * spoed
		else:
			# Friction
			velocity.x = lerp(velocity.x, direction.x * spoed, delta * 7.0)
			velocity.z = lerp(velocity.z, direction.z * spoed, delta * 7.0)
	else:
		# Laat player nog voorentoe gaan as spring en land 
		velocity.x = lerp(velocity.x, direction.x * spoed, delta * 2.0)
		velocity.z = lerp(velocity.z, direction.z * spoed, delta * 2.0)
	#Gravity
	velocity.y -= 20.0 * delta
	#Soek spring key dan gaan op en moet op grond wees
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = 10.0
		#Hou spacebar in, gaan hoer
	elif Input.is_action_just_released("jump") and velocity.y > 0.0:
		velocity.y = 0
	
	# Head bob 
	# Kyk hoe vinnig die head bob moet wees volgens spoed en kyk hoe na amp vir spring
	t_bob += delta * velocity.length() * float(is_on_floor())
	kamera.transform.origin = _headbob(t_bob)
	$Lyf/Arm.transform.origin = _headbob(t_bob)
	
	#Laat toe dat dude kan beweeg met built in metode
	move_and_slide()

func _headbob(time) ->Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * BOB_FREQ) * BOB_AMP
	pos.x = sin(time * BOB_FREQ / 2) * BOB_AMP
	return pos
	
