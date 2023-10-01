extends Node2D

@onready var parent = get_parent()

func _ready():
	var timer = %OrderTimer
	timer.wait_time = Global.order_every_second
	timer.start()

func _on_order_timer_timeout():
	get_parent().add_order()


func _on_child_exiting_tree(node):
	node.tree_exited.connect(
		func():
			parent.compute_orders_pos()
	)
