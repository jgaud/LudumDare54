extends Node2D

@export var meal_scene: PackedScene
@export var order_scene: PackedScene
@onready var oven_node: Node2D = $Oven

var money: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	#TODO: Add meals properly with random values within the dictionary
	add_meal(5, 50, $Fridge/FridgeShelf, Meal.MealType.PIZZA)
	add_meal(1, 1, $Fridge/FridgeShelf2, Meal.MealType.PIZZA)
	
	for i in range(Global.starting_number_orders):
		%OrdersContainer._on_order_timer_timeout()

func add_money(amount):
	money += amount
	%Money.text = str(money) + "$"
	
func add_meal(time, temp, shelf, meal_type):
	var meal = meal_scene.instantiate()
	meal.dropped.connect(_on_meal_dropped)
	meal._set_cooking_params(time, temp)
	meal.meal_type = meal_type
	shelf.add_child(meal)
	
func add_order(time, meal_type: Meal.MealType):
	var order = order_scene.instantiate()
	order.order_initial_time = time
	order.remaining_time = time
	order.asked_meal = meal_type

	%OrdersContainer.add_child(order)
	
func compute_orders_pos():
	for order in %OrdersContainer.get_children():
		var pos = Vector2((order.get_index() * 80) + 2, 0)
		var tween = get_tree().create_tween()
		tween.tween_property(order, "global_position", pos, 1).set_trans(Tween.TRANS_SPRING)
	
func _on_meal_dropped(area):
	var meal = area.get_parent()
	var parent = meal.get_parent()
	
	for area_overlapping in area.get_overlapping_areas():
		var area_overlapping_parent = area_overlapping.get_parent()
		if(area_overlapping_parent is GenericShelf and area_overlapping_parent.active):
			if(area_overlapping_parent.containedItem == null):
				parent.remove_child(meal)
				parent.containedItem = null
				
				area_overlapping_parent.add_child(meal)
				area_overlapping_parent.containedItem = meal
				
				meal.set_global_position(area_overlapping.get_parent().global_position)
				break
	
	meal.position = meal.initial_position


func _on_h_scroll_bar_value_changed(value):
	oven_node.aimed_temp = round(value)
	%AimedTemp.text = str(oven_node.aimed_temp) + "°F"
