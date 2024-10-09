extends Interactable

@export var emptyText : String
@export var fullText : String

enum state {EMPTY, FULL}

var CurentState = state.EMPTY

func _ready():
	CanInteract = true
	setPrompt(emptyText)

func interactEvent(_distance):
	if CurentState == state.FULL:
		CurentState = state.EMPTY
	else:
		CurentState = state.FULL

func getPrompt() -> String:

	if CurentState == state.FULL:
		setPrompt(fullText)
	else:
		setPrompt(emptyText)
		
	return Prompt
