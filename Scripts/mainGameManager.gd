extends Node3D

const customerPreload = preload("res://Scenes/customer.tscn")
var customers : Array[customer]
const customerFollowDistance = 2.0
const customerSpeed = 3.0

func createCustomer():
	var newCustomer = customerPreload.instantiate()
	$Customers.add_child(newCustomer)
	newCustomer.global_position = $Customers/Spawn.global_position
	newCustomer.progress_ratio = 1.0
	
	customers.append(newCustomer)

func _process(delta):
	for i in customers.size():
		if(i == 0):
			customers[i].firstInLine = true
		
		var position = customers[i].progress - customerSpeed * delta
		position = clamp(position, i * customerFollowDistance, $Customers.curve.get_baked_length())
		
		customers[i].progress = position
		if customers[i].progress > $Customers.curve.get_baked_length():
			Global.endGame()

func _ready():
	createCustomer()

func customerSpawnTimeout():
	createCustomer()
