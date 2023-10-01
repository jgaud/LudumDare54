extends Control

var _current_tutorial_step = 0

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_tutorial_button_pressed():
	%HBoxContainer.visible = false
	%TutorialText.visible = true
	%NextButton.visible = true
	_on_next_button_pressed()

func _on_next_button_pressed():
	_current_tutorial_step += 1
	match _current_tutorial_step:
		1:
			$MenuBackground.texture = load("res://art/tutorial/tutorial1.png")
			%TutorialText.text = "Your goal is to fulfill the orders at the top, be careful, if the client waits too long you will lose some money!"
		2:
			$MenuBackground.texture = load("res://art/tutorial/tutorial2.png")
			%TutorialText.text = "Each meal has a different required temperature and cooking time, a meal will not cook under the required temperature."
		3:
			$MenuBackground.texture = load("res://art/tutorial/tutorial3.png")
			%TutorialText.text = "You can control the temperature of the oven. Plan ahead as it rises and decreases slowly. Keep in mind that the temperature drops a lot quicker if the door is opened!"
		4:
			$MenuBackground.texture = load("res://art/tutorial/tutorial4.png")
			%TutorialText.text = "Cooking at a higher temperature makes meals cook faster, but it can also make them burn easily. If you burn a meal, you can throw it away here."
		5:
			$MenuBackground.texture = load("res://art/tutorial/tutorial5.png")
			%TutorialText.text = "Meals appear randomly at a fixed interval if nothing is in the fridge shelf. If you don't have what you need, get rid of the things you don't need to make space."
		6:
			$MenuBackground.texture = load("res://art/tutorial/tutorial6.png")
			%TutorialText.text = "Once you've prepared an order, put it in the delivery zone. It'll be sent to the customer, and you'll make some money."
		7:
			$MenuBackground.texture = load("res://art/tutorial/tutorial7.png")
			%TutorialText.text = "The game ends if your money goes negative or when you finish all the orders. Have fun!"
		8:
			%HBoxContainer.visible = true
			%TutorialText.visible = false
			%NextButton.visible = false
			$MenuBackground.texture = load("res://art/menu_background.png")
	
