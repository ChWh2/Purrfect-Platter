extends Node

var heldItem : Node3D = null

var player : CharacterBody3D

var SCORE : int = 0

func switchScene(newScene : String):
	get_tree().change_scene_to_file(newScene)

func _physics_process(_delta: float) -> void:
	if heldItem and is_instance_valid(heldItem):
		heldItem.global_position = player.get_node("Mesh/Body/HeldPosition").global_position
		
		if Input.is_action_just_pressed("Throw"):
			if heldItem is RigidBody3D:
				heldItem.axis_lock_linear_x = false
				heldItem.axis_lock_linear_y = false
				heldItem.axis_lock_linear_z = false
				
				heldItem.apply_central_force(player.get_node("Mesh/Body/HeldPosition").global_basis.z * -500)
				
				heldItem = null

func useItem() -> void:
	heldItem.queue_free()
	heldItem = null

func endGame() -> void:
	switchScene("res://Scenes/end_screen.tscn")
