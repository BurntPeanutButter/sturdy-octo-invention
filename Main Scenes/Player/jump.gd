extends State

@export var fall_state: State
@export var idle_state: State
@export var move_state: State

@export var jump_force: float = 900

func enter() -> void:
	super()
	parent.velocity.y = -jump_force

func process_physics(delta: float) -> State:
	#Gravity
	parent.velocity.y -= 20.0 * delta
	
	if parent.velocity.y > 0:
		return fall_state
		
	
	
	#Soek spring key dan gaan op en moet op grond wees
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = 10.0
		#Hou spacebar in, gaan hoer
	elif Input.is_action_just_released("jump") and velocity.y > 0.0:
		velocity.y = 0
		
	if is_on_floor():
		move_state
	else:
		# Laat player nog voorentoe gaan as spring en land 
		velocity.x = lerp(velocity.x, direction.x * move_speed, delta * 2.0)
		velocity.z = lerp(velocity.z, direction.z * move_speed, delta * 2.0)
		
