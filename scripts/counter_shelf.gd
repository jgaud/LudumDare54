extends GenericShelf

func _on_child_entered_tree(node):
	super(node)
	
	if(node.current_state == Meal.MealState.COOKED):
		var corresponding_order = null
		
		# Don't do this
		for order in %OrdersContainer.get_children():
			if(order.asked_meal == node.meal_type):
				if(corresponding_order == null or order.remaining_time < corresponding_order.remaining_time):
					corresponding_order = order
				
				
		if(corresponding_order != null):
			get_parent().get_parent().play_sound(Global.order_completed_sound)
			node.get_node("BurningProgressBar").visible = false
			node.get_node("Checkmark").visible = false
			node.get_node("Temperature").visible = false
			node.get_node("Time").visible = false
			var tween = get_tree().create_tween()
			var tween2 = get_tree().create_tween()
			tween.tween_property(node.get_node("Sprite2D"), "position", Vector2.UP * 25, Global.tween_speed).as_relative().from_current()
			tween2.tween_property(node.get_node("Sprite2D"), "modulate:a", 0, Global.tween_speed)
			tween.connect("finished", _on_tween_meal_finished)
			
			corresponding_order.delete_order(round(Global.money_gained_per_order * (corresponding_order.remaining_time)/10))

func _on_tween_meal_finished():
	containedItem.queue_free()
	
