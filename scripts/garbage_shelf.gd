extends GenericShelf


func _on_child_entered_tree(node):
	get_parent().get_parent().play_sound(Global.garbage_sound)
	node.queue_free()
