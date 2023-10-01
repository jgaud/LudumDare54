extends Node2D

@onready var parent = get_parent()

func _ready():
	%OrderTimer.wait_time = Global.order_every_second

func _on_order_timer_timeout():
	var rand_index = randi() % len(Meal.MealType.values())
	
	#TODO: Select from range of time depending on the selected type
	get_parent().add_order(60, Meal.MealType.values()[rand_index])


func _on_child_exiting_tree(node):
	node.tree_exited.connect(
		func():
			parent.compute_orders_pos()
	)
