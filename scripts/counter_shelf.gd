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
			node.get_node("BurningProgressBar").visible = false
			node.get_node("Checkmark").visible = false
			var tween = get_tree().create_tween()
			var tween2 = get_tree().create_tween()
			tween.tween_property(node.get_node("Sprite2D"), "position", Vector2.UP * 25, Global.tween_speed).as_relative().from_current()
			tween2.tween_property(node.get_node("Sprite2D"), "modulate:a", 0, Global.tween_speed)
			tween.connect("finished", _on_tween_meal_finished)
			get_parent().get_parent().add_money(Global.money_per_order * corresponding_order.remaining_time)
			
			corresponding_order.delete_order()

func _on_tween_meal_finished():
	containedItem.queue_free()
	
