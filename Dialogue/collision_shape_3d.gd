extends CollisionShape3D

@onready var dialog_ui: RichTextLabel = get_tree().current_scene.get_node("res://Dialogue/dialog_ui.tscn/CanvasLayer")
@onready var speaker_name: RichTextLabel = get_tree().current_scene.get_node("res://Dialogue/dialog_ui.tscn/speaker_name")
@onready var dialogue: RichTextLabel = get_tree().current_scene.get_node("res://Dialogue/dialog_ui.tscn/dialogue")
@onready var player: RichTextLabel = get_tree().current_scene.get_node("player")

@export var dialogues: Array[String]
@export var speaker_names: Array[String]
@export var speaker: Node3D

var current_dialogue = -1
var started = false

func continue_dialogue():
	current_dialogue += 1
	if !dialog_ui.visible:
		dialog_ui.visible = true
	dialogue.text = dialogues[current_dialogue]
