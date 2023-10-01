extends Node2D

@export var meal_scene: PackedScene
@export var order_scene: PackedScene
@onready var oven_node: Node2D = $Oven
@onready var audio_stream_player = %AudioStreamPlayer

var money: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	add_meal($Fridge/FridgeShelf, Meal.MealType.PIZZA)
	add_meal($Fridge/FridgeShelf2, Meal.MealType.PIZZA, 0, 0)
	
	add_order(Meal.MealType.PIZZA, 1)
	for i in range(Global.starting_number_orders):
		add_order()

func add_money(amount):
	money += amount
	%Money.text = str(money) + "$"
	check_game_over()
	
func check_game_over():
	if(money < 0):
		#Lose
		get_tree().paused = true
		%EndGame.get_node("%ScoreLabel").text = "You ran out of money"
		%EndGame.visible = true
		
	elif(%OrdersContainer.get_child_count() == 0):
		#Win
		get_tree().paused = true
		%EndGame.get_node("%Label").text = "Congratulations, you won!"
		%EndGame.get_node("%ScoreLabel").text = "Score: " + str(money)
		%EndGame.visible = true
	
func add_meal(shelf, meal_type=null, time=null, temp=null):	
	var random = RandomNumberGenerator.new()
	random.randomize()
	
	if(meal_type == null):
		var rand_index = randi() % len(Meal.MealType.values())
		meal_type = Meal.MealType.values()[rand_index]
	
	if(time == null):
		time = randi_range(round(Global.meals_info[meal_type].time_min), round(Global.meals_info[meal_type].time_max))
	if(temp == null):
		temp = (random.randi_range(round(Global.meals_info[meal_type].temp_min/50), round(Global.meals_info[meal_type].temp_max/50))) * 50
		
	var meal = meal_scene.instantiate()
	meal.dropped.connect(_on_meal_dropped)
	meal._set_cooking_params(time, temp)
	meal.meal_type = meal_type
	meal.get_node("Sprite2D").texture = Global.meals_info[meal_type].texture
	shelf.containedItem = meal
	shelf.add_child(meal)
	
func add_order(meal_type=null, time=null):
	var random = RandomNumberGenerator.new()
	random.randomize()
	
	if(meal_type == null):
		var rand_index = randi() % len(Meal.MealType.values())
		meal_type = Meal.MealType.values()[rand_index]
	
	if(time == null):
		time = randi_range(round(Global.meals_info[meal_type].time_max), round((Global.meals_info[meal_type].time_max)*0.10))
	
	var order = order_scene.instantiate()
	order.order_initial_time = time
	order.remaining_time = time
	order.asked_meal = meal_type

	%OrdersContainer.add_child(order)

func compute_orders_pos(node=null):
	for order in %OrdersContainer.get_children():
		if(self.is_inside_tree()):
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
	
	var tween = get_tree().create_tween()
	tween.tween_property(meal, "position", meal.initial_position, 0.2)	


func _on_h_scroll_bar_value_changed(value):
	oven_node.aimed_temp = round(value)
	%AimedTemp.text = str(oven_node.aimed_temp) + "°F"

func play_sound(sound):
	audio_stream_player.stream = sound
	audio_stream_player.play()
