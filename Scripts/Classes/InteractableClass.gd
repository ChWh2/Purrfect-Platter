class_name Interactable
extends Node

var Prompt : String

func interactEvent(distance : float) -> void:
	print(str("interacted: ", name, " at: ", distance))

func setPrompt(text : String) -> void:
	Prompt = text

func getPrompt() -> String:
	return Prompt
