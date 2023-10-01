extends Control

var order_initial_time: float = 10
var remaining_time: float = 10
var asked_meal: Meal.MealType

func _on_order_timer_timeout():
	if(remaining_time > 0):
		remaining_time -= 1
		$TextureProgressBar.value = (remaining_time / order_initial_time) * 100

func _enter_tree():
	#TODO: Replace the sprite with the proper sprite depending on asked_meal
	match asked_meal:
		Meal.MealType.LASAGNA:
			print("Lasagna")
		Meal.MealType.PIZZA:
			print("Pizza")
