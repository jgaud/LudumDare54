extends Node2D

var order_initial_time: float = 10
var remaining_time: float = 10
var asked_meal: Meal.MealType

func _on_order_timer_timeout():
	if(remaining_time > 0):
		remaining_time -= 1
		$TextureProgressBar.value = (remaining_time / order_initial_time) * 100
	
	elif(remaining_time <= 0):
		get_parent().get_parent().add_money(-Global.money_lost_per_order)
		delete_order()

func _enter_tree():
	$MealSprite.texture = Global.meals_info[asked_meal].texture

func delete_order():
	var tween3 = get_tree().create_tween()
	var tween4 = get_tree().create_tween()
	tween3.tween_property(self, "modulate:a", 0, Global.tween_speed)
	tween4.tween_property(self, "position", Vector2.UP * 100, Global.tween_speed).as_relative().from_current()
	tween3.connect("finished", _on_tween_order_finished)
	
func _on_tween_order_finished():
	var parent = get_parent()
	parent.remove_child(self)
	self.queue_free()
