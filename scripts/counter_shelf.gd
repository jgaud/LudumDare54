extends GenericShelf

func _on_child_entered_tree(node):
	super(node)
	
	if(node.current_state == Meal.MealState.COOKED):
		#TODO: Check if its actually an order
		#TODO: Increase money or score
		var tween = get_tree().create_tween()
		tween.tween_property(node.get_node("Sprite2D"), "position", Vector2.UP * 25, 0.5).as_relative().from_current()
		tween.tween_property(node.get_node("Sprite2D"), "modulate:a", 0, 0.05)
		tween.connect("finished", _on_tween_finished)
	
func _on_tween_finished():
	containedItem.queue_free()
