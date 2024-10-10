extends Interactable

@export var emptyText : String
@export var fullText : String

@export var cookTime := 1.0
@export var burnTime := 5.0

enum state {EMPTY, COOKING, BURNING, BURNT}

var CurentState = state.EMPTY

var currentItem : Node3D

@onready var cookTimer = $CookTimer
@onready var burnTimer = $BurnTimer

func _ready():
	cookTimer.wait_time = cookTime
	burnTimer.wait_time = burnTime
	
	CanInteract = true
	setPrompt(emptyText)

func _process(_delta: float) -> void:
	CanInteract = testIfCanInteract()
	
	if(currentItem):
		currentItem.position = position

func testIfCanInteract() -> bool:
	if CurentState == state.EMPTY:
		if is_instance_valid(Global.heldItem):
			if Global.heldItem is Grabable:
				if Global.heldItem.itemID == 1 and CurentState != state.COOKING:
					return true
	elif CurentState != state.COOKING:
		if Global.heldItem == null:
			return true
	
	return false

func interactEvent(_distance):
	if CurentState == state.BURNING or CurentState == state.BURNT:
		Global.heldItem = currentItem
		currentItem = null
		
		burnTimer.stop()
		cookTimer.stop()
		CurentState = state.EMPTY
		$Ready.text = ""
		$Fire.emitting = false
		
	elif CurentState == state.EMPTY:
		currentItem = Global.heldItem
		Global.heldItem = null
		
		CurentState = state.COOKING
		cookTimer.start()
		$Fire.emitting = true
		CanInteract = false

func getPrompt() -> String:
	if CanInteract == false:
		setPrompt("")
	elif CurentState == state.BURNING or CurentState == state.BURNT:
		setPrompt(fullText)
	elif CurentState == state.EMPTY:
		setPrompt(emptyText)
	else:
		setPrompt("")
	
	return Prompt

func cookTimeout():
	print("cooked")
	
	if currentItem is Grabable:
		currentItem.itemID = 2
	
	CurentState = state.BURNING
	burnTimer.start()
	$Ready.text = "!"
	CanInteract = true
	
func burnTimeout():
	if currentItem is Grabable:
		currentItem.itemID = 3
	
	print("burnt")
	CurentState = state.BURNT
