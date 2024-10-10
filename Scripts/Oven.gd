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

func _process(delta: float) -> void:
	if(CurentState == state.EMPTY):
		$Fire.emitting = false
	else:
		$Fire.emitting = true
	
	if(CurentState == state.COOKING):
		CanInteract = false
	else:
		CanInteract = true

func interactEvent(_distance):
	if CurentState == state.BURNING or CurentState == state.BURNT:
		CurentState = state.EMPTY
	elif CurentState == state.EMPTY:
		CurentState = state.COOKING
		cookTimer.start()

func getPrompt() -> String:

	if CurentState == state.BURNING or CurentState == state.BURNT:
		setPrompt(fullText)
	elif CurentState == state.EMPTY:
		setPrompt(emptyText)
		
	return Prompt

func cookTimeout():
	print("cooked")
	CurentState = state.BURNING
	burnTimer.start()
func burnTimeout():
	print("burnt")
	CurentState = state.BURNT
