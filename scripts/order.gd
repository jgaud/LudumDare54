extends Control

var order_initial_time: int = 10
var remaining_time: int = 10

func _on_order_timer_timeout():
	if(remaining_time > 0):
		remaining_time -= 1
		$TextureProgressBar.value = (remaining_time / order_initial_time) * 100
		print($TextureProgressBar.valu)
