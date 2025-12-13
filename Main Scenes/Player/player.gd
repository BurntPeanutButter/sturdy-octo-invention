class_name Player
extends CharacterBody3D

var spoed: float
var SPOED_LOOP: float = 5.0
var SPOED_HARDLOOP: float = 8.0
@export var sensitivity: float = 0.1

@export var accel: float        # acceleration factor
@export var friction: float     # deceleration factor
@export var jump_force: float = 10.0

# Head bob constants
const BOB_FREQ = 2.0
const BOB_AMP = 0.08
var t_bob = 0.0

# References from nodes
@onready var kamera = $Kop/Camera3D
@onready var animations = $Lyf/RegterArm/AnimationPlayer
@onready var state_machine = $state_machine	
@onready var raycast: RayCast3D = $Kop/RayCast3D

# Input tracking for states
var input_dir_2d: Vector2 = Vector2.ZERO
var input_dir_3d: Vector3 = Vector3.ZERO

func _ready() -> void:
	state_machine.init(self)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event: InputEvent) -> void:
	# Mouse look
	if event is InputEventMouseMotion:
		# Look left / right
		rotation_degrees.y -= event.relative.x * sensitivity
		
		# Look up / down
		kamera.rotation_degrees.x -= event.relative.y * sensitivity
		kamera.rotation_degrees.x = clamp(kamera.rotation_degrees.x, -80.0, 80.0)
		
	# Escape key: show mouse
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	# Left click: hide mouse
	elif event.is_action_pressed("left_click"):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		
		
	# Pass to state machine for jump / other input handling
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	# Get movement input
	input_dir_2d = Input.get_vector(
		"move_left", "move_right", "move_forward", "move_back"
	)
	
	# Convert to 3D directional input
	input_dir_3d = Vector3.ZERO
	if input_dir_2d != Vector2.ZERO:
		input_dir_3d = (transform.basis * Vector3(input_dir_2d.x, 0.0, input_dir_2d.y)).normalized()
	
	# Head bob
	t_bob += delta * velocity.length() * float(is_on_floor())
	kamera.transform.origin = _headbob(t_bob)
	$Lyf/RegterArm.transform.origin = _headbob2(t_bob)
	
	# Let state machine handle movement, gravity, jumping
	state_machine.process_physics(delta)
	

func _process(delta: float) -> void:
	state_machine.process_frame(delta)

func _headbob(time: float) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * BOB_FREQ) * BOB_AMP
	pos.x = sin(time * BOB_FREQ / 2) * BOB_AMP
	return pos
	
func _headbob2(time: float) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * BOB_FREQ) * BOB_AMP - 1
	pos.x = sin(time * BOB_FREQ / 2) * BOB_AMP + 0.5
	return pos


func _on_button_interacted() -> void:
	pass # Replace with function body.
