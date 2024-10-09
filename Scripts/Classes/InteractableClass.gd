class_name Interactable
extends Node3D

var Prompt : String
var CanInteract : bool = false

func interact(distance : float) -> void:
	if CanInteract:
		interactEvent(distance)

func interactEvent(distance : float) -> void:
	print(str("interacted: ", name, " at: ", distance))

func setPrompt(text : String) -> void:
	Prompt = text

func getPrompt() -> String:
	return Prompt
