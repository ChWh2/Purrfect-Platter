extends Interactable

var readyToDispense = true

const fishPreload = preload("res://Scenes/fish.tscn")

func _ready():
	CanInteract = true

func cooldownTimeout():
	CanInteract = true
	readyToDispense = true

func interactEvent(_distance):
	CanInteract = false
	readyToDispense = false
	$cooldown.start()
	
	var fish = fishPreload.instantiate()
	get_tree().current_scene.get_node("Fish").add_child(fish)
	fish.global_position = $SpawnPosition.global_position

func getPrompt() -> String:
	if(readyToDispense):
		Prompt = "Dispense"
	else:
		Prompt = str($cooldown.time_left).pad_decimals(2)
	return Prompt
