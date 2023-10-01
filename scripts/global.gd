extends Node

@export var temp_change_speed: float
@export var temp_opened_change_speed: float
@export var temp_closed_change_speed: float
@export var tween_speed: float
@export var money_gained_per_order: int
@export var money_lost_per_order: int
@export var order_every_second: int
@export var meal_every_second: int
@export var starting_number_orders: int

@onready var meals_info = {
	Meal.MealType.LASAGNA: {
		"label": "Lasagna",
		"temp_min": 50,
		"temp_max": 350,
		"time_min": 10,
		"time_max": 100,
		"texture": load("res://art/meals/meal_placeholder.png")
	},
	Meal.MealType.PIZZA: {
		"label": "Pizza",
		"temp_min": 50,
		"temp_max": 350,
		"time_min": 10,
		"time_max": 100,
		"texture": load("res://art/meals/meal_placeholder.png")
	}
}
