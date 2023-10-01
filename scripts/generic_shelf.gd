extends Node2D

class_name GenericShelf

var active: bool = true
var containedItem: Meal

func _ready():
	child_entered_tree.connect(_on_child_entered_tree)
	child_exiting_tree.connect(_on_child_exited_tree)

func _on_child_entered_tree(node):
	get_tree().current_scene.play_sound(Global.meal_dropped_sound)
	containedItem = node

func _on_child_exited_tree(node):
	containedItem = null
