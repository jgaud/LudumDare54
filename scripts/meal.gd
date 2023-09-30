extends Node2D


signal dropped(area)

@onready var initial_position: Vector2 = position
@onready var _progress_bar = $TextureProgressBar

var dragged: bool
var start_drag_mouse_pos

var _progress: float = 0
var cook_time: int
var cook_temp: int
var remaining_cooking: float


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(dragged):
		var new_pos = get_global_mouse_position()
		new_pos -= start_drag_mouse_pos
		global_position = new_pos
		
	if(remaining_cooking != 0):
		_progress = (1 - (remaining_cooking / (cook_temp * cook_time))) * 100

		if(_progress_bar.value != _progress):
			if(!_progress_bar.visible):
				_progress_bar.visible = true
			
			_progress_bar.value = _progress

func _set_cooking_params(time, temp):
	cook_time = time
	cook_temp = temp
	remaining_cooking = cook_time * cook_temp

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if Input.is_action_just_pressed("click"):
			dragged = true
			start_drag_mouse_pos = get_local_mouse_position()
		elif Input.is_action_just_released("click") and dragged:
			dragged = false
			dropped.emit($Area2D)
