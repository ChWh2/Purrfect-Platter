class_name Grabable
extends Interactable

@export var itemName : String
@export var itemID : int

func _physics_process(_delta: float) -> void:
	if !Global.heldItem:
		CanInteract = true
		Prompt = str("Pick up ", itemName)
	else:
		CanInteract = false
		Prompt = ""
	
	

func interactEvent(_distance : float) -> void:
	var testForRigidbodyArray = self.get_parent().get_children()
	var rb : RigidBody3D
	for i in testForRigidbodyArray.size():
		if testForRigidbodyArray[i] is RigidBody3D and testForRigidbodyArray[i] == self:
			rb = testForRigidbodyArray[i]
	
	if rb:
		rb.axis_lock_linear_x = true
		rb.axis_lock_linear_y = true
		rb.axis_lock_linear_z = true
		
	Global.heldItem = self
