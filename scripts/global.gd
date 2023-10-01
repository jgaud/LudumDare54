extends Node

@export var click_sound: AudioStreamWAV
@export var garbage_sound: AudioStreamWAV
@export var oven_door_sound: AudioStreamWAV
@export var order_completed_sound: AudioStreamWAV
@export var order_failed_sound: AudioStreamWAV
@export var meal_dropped_sound: AudioStreamWAV

@export var temp_change_speed: float
@export var temp_opened_change_speed: float
@export var temp_closed_change_speed: float
@export var tween_speed: float
@export var money_gained_per_order: int
@export var money_lost_per_order: int
@export var order_every_second: int
@export var meal_every_second: int
@export var starting_number_orders: int
@export var time_per_order: int
@export var burning_factor: float
@export var wait_time_periodic_decrease: float

@onready var meals_info = {
	Meal.MealType.LASAGNA: {
		"label": "Lasagna",
		"temp_min": 250,
		"temp_max": 400,
		"time_min": 5,
		"time_max": 10,
		"texture": load("res://art/meals/lasagna.png"),
		"texture_burned": load("res://art/meals/lasagna_burned.png")
	},
	Meal.MealType.PIZZA: {
		"label": "Pizza",
		"temp_min": 500,
		"temp_max": 500,
		"time_min": 5,
		"time_max": 10,
		"texture": load("res://art/meals/pizza.png"),
		"texture_burned": load("res://art/meals/pizza_burned.png")
	},
	Meal.MealType.PATE: {
		"label": "Paté",
		"temp_min": 50,
		"temp_max": 350,
		"time_min": 5,
		"time_max": 15,
		"texture": load("res://art/meals/pate.png"),
		"texture_burned": load("res://art/meals/pate_burned.png")
	},
	Meal.MealType.STEW: {
		"label": "Stew",
		"temp_min": 50,
		"temp_max": 150,
		"time_min": 10,
		"time_max": 20,
		"texture": load("res://art/meals/stew.png"),
		"texture_burned": load("res://art/meals/stew_burned.png")
	}
}
