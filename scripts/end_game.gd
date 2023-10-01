extends Control



func _on_restart_button_pressed():
	get_parent().get_parent().play_sound(Global.click_sound)
	get_tree().reload_current_scene()
	get_tree().paused = false


func _on_main_menu_button_pressed():
	get_parent().get_parent().play_sound(Global.click_sound)
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
