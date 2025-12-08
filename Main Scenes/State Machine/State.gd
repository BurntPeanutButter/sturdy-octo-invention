class_name State
extends Node

@export var animation_name: String

var gravity: float = 20

#Beheer player
var parent: Player

func enter() -> void:
	parent.animations.play("idle")
	
func exit() -> void:
	pass

func process_input(event: InputEvent) -> State:
	return null
	
func process_frame(delta: float) -> State:
	return null
	
func process_physics(delta: float) -> State:
	return null
