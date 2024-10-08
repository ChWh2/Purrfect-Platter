extends CharacterBody2D


@export var speed = 300.0

func _physics_process(_delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if direction:
		velocity = direction.normalized() * speed * 100.0
	else:
		velocity.x = move_toward(velocity.x, 0, speed * 100.0)
		velocity.y = move_toward(velocity.y, 0, speed * 100.0)

	move_and_slide()
