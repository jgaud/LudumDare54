extends GenericShelf


func _on_child_entered_tree(node):
	node.queue_free()
