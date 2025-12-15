extends CharacterBody3D

@export var speed := 3.0
@export var jump_speed := 14.0
@export var player_path : NodePath
const GRAVITY := 24.8

func _physics_process(delta):
	# Apply gravity
	if not is_on_floor():
		velocity.y -= GRAVITY * delta
	else:
		velocity.y = 0

	# Move toward player
	if player_path:
		var player = get_node_or_null(player_path)
		if player:
			var dir = player.global_position - global_position
			dir.y = 0
			dir = dir.normalized()

			velocity.x = dir.x * speed
			velocity.z = dir.z * speed

			# Gap/wall detection using one ray
			var ray = $RayCast3D
			if ray:  # safety check so it won't throw errors
				ray.force_raycast_update()
				# jump if there is a gap ahead or wall in front
				if is_on_floor() and not ray.is_colliding():
					velocity.y = jump_speed

	# Move the chaser
	move_and_slide()
