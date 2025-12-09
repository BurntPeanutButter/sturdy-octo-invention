extends CollisionShape3D

<<<<<<< Updated upstream
@onready var speaker_name: String = get_tree().current_scene.get_node("res://Testing Scenes/Platform.tscn")
=======
#Soek dialogue UI sodaat ons dit wegsteek  na die tyd
@onready var dialogue_ui: RichTextLabel = get_tree().current_scene.get_node("res://Dialogue/dialog_ui.tscn/CanvasLayer")
#Speel "scroll" animation in dialogue ui
@onready var dialogue_animation: RichTextLabel = get_tree().current_scene.get_node("res://Dialogue/dialog_ui.tscn/CanvasLayer/AnimationPlayer")
#Gaan deur elke spreeker se naam
@onready var speaker_name: RichTextLabel = get_tree().current_scene.get_node("res://Dialogue/dialog_ui.tscn/speaker_name")
#Gaan deur alle dialogue
@onready var dialogue: RichTextLabel = get_tree().current_scene.get_node("res://Dialogue/dialog_ui.tscn/dialogue")
#Soek ons player node
@onready var player: RichTextLabel = get_tree().current_scene.get_node("player")

#Stoor dialogues
@export var dialogues: Array[String]
#Stoor name van mense wie praat
@export var speaker_names: Array[String]
#Wie praat
@export var speaker: Node3D

var current_dialogue = -1
var started = false

func start_dialogue(body):
	if body == player and !started:
		started = true
		player.get_node("player").SPOED_LOOP = 5.0
		player.get_node("player").SPOED_HARDLOOP = 5.0
		player.get_node("player").sensitivity = 0.0
		dialogue_ui.visible = true
		speaker.look_at(player.global_transform.origin)
		speaker.rotation_degrees.x = 0
		speaker.rotation_degrees.z = 0
		continue_dialogue()

func end_dialogue():
	
	
	
func continue_dialogue():
	current_dialogue += 1
	if current_dialogue < dialogues.size():
		dialogue.text = dialogues[current_dialogue]
		speaker_name.text = speaker_names[current_dialogue]
		dialogue_animation.play("RESET")
		dialogue_animation.play("scroll")
	else:
		pass
>>>>>>> Stashed changes
