class_name customer
extends PathFollow3D

@onready var patience = $Patience
@onready var patienceBar = $PatienceBar

var firstInLine : bool = false

var readyForDeletion : bool = false


func _process(_delta):
	patienceBar.text = str(patience.time_left).pad_decimals(2)

func patienceTimeout():
	Global.endGame()

func enterGrabRadius(body):
	if body is Grabable:
		if body.itemID == 2:
			eatFish(body)
			readyForDeletion = true

func eatFish(fish : Grabable):
	if Global.heldItem == Grabable:
		Global.useItem()
	else:
		fish.queue_free()
