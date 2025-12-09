extends Node3D

#Soek dialogue UI sodaat ons dit wegsteek  na die tyd
@onready var dialogue_ui: CanvasLayer = get_tree().current_scene.get_node("Dialog_UI/Canvas")
#Speel "scroll" animation in dialogue ui
@onready var dialogue_animation: AnimationPlayer = get_tree().current_scene.get_node("Dialog_UI/Canvas/AnimationPlayer")
#Gaan deur elke spreeker se naam
@onready var speaker_name: RichTextLabel = get_tree().current_scene.get_node("Dialog_UI/Canvas/speaker_name")
#Gaan deur alle dialogue
@onready var dialogue: RichTextLabel = get_tree().current_scene.get_node("Dialog_UI/Canvas/dialogue")
#Soek ons player node
@onready var player: CharacterBody3D = get_tree().current_scene.get_node("Player")

#Stoor dialogues
@export var dialogues: Array[String]
#Stoor name van mense wie praat
@export var speaker_names: Array[String]
#Wie praat
@export var speaker: Node3D

var current_dialogue = -1
var started = false

func _ready() -> void:
	dialogue_ui.get_node("continue").connect("pressed", Callable(self, "continue_dialogue"))

func start_dialogue(body):
	if body == player and !started:
		started = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		player.SPOED_LOOP = 0.0
		player.SPOED_HARDLOOP = 0.0
		player.sensitivity = 0.0
		dialogue_ui.visible = true
		speaker.look_at(player.global_transform.origin)
		speaker.rotation_degrees.x = 0
		speaker.rotation_degrees.z = 0
		player.look_at(speaker.global_transform.origin)
		player.rotation_degrees.z = 0
		player.rotation_degrees.x = 0
		player.get_node("Kop").look_at(speaker.get_node("Kop").global_transform.origin)
		player.get_node("Kop").rotation_degrees.x = 0
		
		continue_dialogue()

func end_dialogue():
	player.SPOED_LOOP = 5.0
	player.SPOED_HARDLOOP = 8.0
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	player.sensitivity = 0.1
	dialogue_ui.visible = false
	speaker.get_node("AnimationPlayer").play("RESET")
	
func continue_dialogue():
	current_dialogue += 1
	if current_dialogue < dialogues.size():
		dialogue.text = dialogues[current_dialogue]
		speaker_name.text = speaker_names[current_dialogue]
		if "You" not in speaker_name.text:
			speaker.get_node("AnimationPlayer").play("talk")
		else:
			speaker.get_node("AnimationPlayer").play("RESET")
		dialogue_animation.play("scroll")
	else:
		end_dialogue()
