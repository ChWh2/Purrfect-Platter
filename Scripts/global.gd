extends Node

var heldItem : Node3D = null

var player : CharacterBody3D

func _ready() -> void:
	player = get_tree().current_scene.get_node("player")

func _process(_delta: float) -> void:
	if heldItem:
		heldItem.global_position = player.get_node("Mesh/Body/HeldPosition").global_position
		
		if Input.is_action_just_pressed("Throw"):
			if heldItem is RigidBody3D:
				heldItem.axis_lock_linear_x = false
				heldItem.axis_lock_linear_y = false
				heldItem.axis_lock_linear_z = false
				
				heldItem.apply_central_force(player.get_node("Mesh/Body/HeldPosition").global_basis.z * -500)
				
				heldItem = null

func useItem() -> void:
	heldItem.free()
	heldItem = null
