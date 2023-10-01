extends Node2D


func _on_child_entered_tree(node):
	get_parent().compute_orders_pos()
