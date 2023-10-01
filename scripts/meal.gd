extends Node2D

class_name Meal

signal dropped(area)

enum MealState {UNCOOKED, COOKED, BURNED}
enum MealType {LASAGNA, PIZZA}

@export var burned_meal_texture: Texture 

@onready var initial_position: Vector2 = position
@onready var _progress_bar = $TextureProgressBar
@onready var _burning_progress_bar = $BurningProgressBar

var dragged: bool
var start_drag_mouse_pos

var _progress: float = 0
var _burning_progress: float = 0
var cook_time: int
var cook_temp: int
var remaining_cooking: float
var current_state: MealState = MealState.UNCOOKED
var meal_type: MealType

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(dragged):
		var new_pos = get_global_mouse_position()
		new_pos -= start_drag_mouse_pos
		global_position = new_pos
		
	if(current_state == MealState.UNCOOKED and remaining_cooking > 0):
		_progress = (1 - (remaining_cooking / (cook_temp * cook_time))) * 100

		if(_progress_bar.value != _progress):
			if(!_progress_bar.visible):
				_progress_bar.visible = true
			
			_progress_bar.value = _progress
			
	elif(current_state == MealState.UNCOOKED and remaining_cooking <= 0):
		current_state = MealState.COOKED
		$Checkmark.visible = true
	
	elif(current_state == MealState.COOKED and remaining_cooking < 0):
		#Meal is burning!!
		_burning_progress = abs(remaining_cooking / (cook_temp * cook_time)) * 100
		
		if(_burning_progress_bar.value != _burning_progress):
			if(_progress_bar.visible):
				_progress_bar.visible = false
				_burning_progress_bar.visible = true
				
			_burning_progress_bar.value = _burning_progress
		
		if(_burning_progress >= 100):
			current_state = MealState.BURNED
			_burning_progress_bar.visible = false
			$Checkmark.visible = false
			$Sprite2D.texture = burned_meal_texture
			#TODO: Display correct burned sprite

func _set_cooking_params(time, temp):
	cook_time = time
	cook_temp = temp
	remaining_cooking = cook_time * cook_temp

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if(Input.is_action_just_pressed("click") and get_parent().active):
			dragged = true
			start_drag_mouse_pos = get_local_mouse_position()
		elif(Input.is_action_just_released("click") and dragged):
			dragged = false
			dropped.emit($Area2D)
