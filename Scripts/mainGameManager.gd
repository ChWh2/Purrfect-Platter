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

func destroyCustomer(i : int):
	var c = customers[i]
	customers.remove_at(i)
	c.queue_free()

func _ready():
	Global.SCORE = 0
	createCustomer()

func _process(delta):
	for c in customers:
		if(c.readyForDeletion):
			destroyCustomer(customers.find(c))
	
	for c in customers:
		var customerPosition = c.progress - customerSpeed * delta
		customerPosition = clamp(customerPosition,  customers.find(c) * customerFollowDistance, $Customers.curve.get_baked_length())
		
		c.progress = customerPosition

func customerSpawnTimeout():
	$CustomerSpawnTimer.wait_time -= $CustomerSpawnTimer.wait_time/7.0
	$CustomerSpawnTimer.wait_time = clamp($CustomerSpawnTimer.wait_time, 6, 15)
	
	createCustomer()
