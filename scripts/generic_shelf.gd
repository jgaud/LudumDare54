extends Node2D

class_name GenericShelf

var active: bool = true
var containedItem: Node2D

func _ready():
	child_entered_tree.connect(_on_child_entered_tree)
	child_exiting_tree.connect(_on_child_exited_tree)

func _on_child_entered_tree(node):
	containedItem = node

func _on_child_exited_tree(node):
	containedItem = null
