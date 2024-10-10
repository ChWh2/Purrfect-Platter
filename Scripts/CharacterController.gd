extends CharacterBody3D


var speed = 5.0

@onready var body = $Mesh

var interactsInRadius : Array[Node3D]

func InteractEnter(enterBody : Node3D):
	interactsInRadius.append(enterBody)

func InteractExit(exitBody : Node3D):
	var bodyInArray = interactsInRadius.find(exitBody)
	interactsInRadius.remove_at(bodyInArray)

func Interact():
	if interactsInRadius.size() > 0:
		$Label3D.visible = true
		
		var closestInteractable : Node3D
		var closestInteractableRadius = 100.0
		
		for interactible in interactsInRadius.size():
			if position.distance_to(interactsInRadius[interactible].position) < closestInteractableRadius:
				closestInteractableRadius = position.distance_to(interactsInRadius[interactible].position)
				closestInteractable = interactsInRadius[interactible]
		
		$Label3D.text = closestInteractable.getPrompt()
		$Label3D.global_position = closestInteractable. global_position
		
		if Input.is_action_just_pressed("Interact"):
			closestInteractable.interact(closestInteractableRadius)
		
	else:
		$Label3D.visible = false

func _physics_process(_delta: float) -> void:
	
	Interact()
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("Left", "Right", "Up", "Down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		
		body.look_at(direction + global_position, Vector3.UP)
		
		
		
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	move_and_slide()
