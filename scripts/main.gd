extends Node2D

@export var meal_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	#TODO: Change this section depending on the level
	var meal = meal_scene.instantiate()
	meal.dropped.connect(_on_meal_dropped)
	$Fridge/FridgeShelf.add_child(meal)
	
	var meal2 = meal_scene.instantiate()
	meal2.dropped.connect(_on_meal_dropped)
	$Fridge/FridgeShelf2.add_child(meal2)

func _on_meal_dropped(area):
	var meal = area.get_parent()
	var parent = meal.get_parent()
	
	for area_overlapping in area.get_overlapping_areas():
		var area_overlapping_parent = area_overlapping.get_parent()
		if(area_overlapping_parent is GenericShelf):
			if(area_overlapping_parent.containedItem == null):
				parent.remove_child(meal)
				area_overlapping_parent.add_child(meal)
				meal.set_global_position(area_overlapping.get_parent().global_position)
				break
	
	meal.position = meal.initial_position


func _on_h_scroll_bar_value_changed(value):
	%AimedDegrees.text = str(round(value)) + "°F"
