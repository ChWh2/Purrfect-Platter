class_name customer
extends PathFollow3D

@onready var patience = $Patience
@onready var patienceBar = $PatienceBar

var firstInLine : bool = false


func _process(_delta):
	patienceBar.text = str(patience.time_left).pad_decimals(2)

func patienceTimeout():
	Global.endGame()
