extends Node2D

@onready var parent = get_parent()

func _ready():
	var timer = %OrderTimer
	timer.wait_time = Global.order_every_second
	timer.start()

func _on_order_timer_timeout():
	get_parent().add_order()
	
	if(%OrderTimer.wait_time > 5):
		%OrderTimer.wait_time -= Global.wait_time_periodic_decrease


func _on_child_exiting_tree(node):
	node.tree_exited.connect(
		func():
			parent.compute_orders_pos()
	)
