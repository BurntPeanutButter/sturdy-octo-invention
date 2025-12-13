extends RayCast3D

@onready var prompt_label = $"../Control/CanvasLayer/Prompt"

func _process(delta: float) -> void:
	if not is_colliding():
		prompt_label.text = ""
	else:
		var collider = get_collider()
		if collider is Interactable:
			prompt_label.text = collider.get_prompt()
			
			if Input.is_action_just_pressed(collider.prompt_action):
				collider.interact(owner)
		else:
			prompt_label.text = ""
