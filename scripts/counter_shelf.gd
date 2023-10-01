extends GenericShelf

@export var tween_speed: float
var corresponding_order

func _on_child_entered_tree(node):
	super(node)
	
	if(node.current_state == Meal.MealState.COOKED):
		corresponding_order = null
		
		# Don't do this
		for order in %OrdersContainer.get_children():
			if(order.asked_meal == node.meal_type):
				if(corresponding_order == null or order.remaining_time < corresponding_order.remaining_time):
					corresponding_order = order
				
				
		if(corresponding_order != null):
			node.get_node("BurningProgressBar").visible = false
			var tween = get_tree().create_tween()
			var tween2 = get_tree().create_tween()
			tween.tween_property(node.get_node("Sprite2D"), "position", Vector2.UP * 25, tween_speed).as_relative().from_current()
			tween2.tween_property(node.get_node("Sprite2D"), "modulate:a", 0, tween_speed)
			tween.connect("finished", _on_tween_meal_finished)
			
			var tween3 = get_tree().create_tween()
			var tween4 = get_tree().create_tween()
			tween3.tween_property(corresponding_order, "modulate:a", 0, tween_speed)
			tween4.tween_property(corresponding_order, "position", Vector2.UP * 100, tween_speed).as_relative().from_current()
			tween3.connect("finished", _on_tween_order_finished)
			#var parent = corresponding_order.get_parent()
			#parent.remove_child(corresponding_order)

func _on_tween_meal_finished():
	containedItem.queue_free()
	#TODO: Increase money depending on the time left
	get_parent().get_parent().add_money(10)
	
func _on_tween_order_finished():
	var parent = corresponding_order.get_parent()
	parent.remove_child(corresponding_order)
	corresponding_order.queue_free()
	get_tree().root.get_child(0).compute_orders_pos()
