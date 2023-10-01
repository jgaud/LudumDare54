extends Node2D

func _ready():
	%OrderTimer.wait_time = Global.order_every_second

func _on_child_entered_tree(node):
	get_parent().compute_orders_pos()


func _on_order_timer_timeout():
	var rand_index = randi() % len(Meal.MealType.values())
	
	#TODO: Select from range of time depending on the selected type
	get_parent().add_order(60, Meal.MealType.values()[rand_index])
	#add_order(40, Meal.MealType.PIZZA)
