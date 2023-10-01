extends GenericShelf

func _ready():
	var timer = $CreateMealTimer
	timer.wait_time = Global.meal_every_second
	timer.start()

func _on_create_meal_timer_timeout():
	if(containedItem == null):
		get_parent().get_parent().add_meal(self)
