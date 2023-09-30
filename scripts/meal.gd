extends Node2D

signal dropped(area)

var dragged: bool
var start_drag_mouse_pos
@onready var initial_position: Vector2 = position
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(dragged):
		var new_pos = get_global_mouse_position()
		new_pos -= start_drag_mouse_pos
		global_position = new_pos


func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if Input.is_action_pressed("click"):
			dragged = true
			start_drag_mouse_pos = get_local_mouse_position()
		elif Input.is_action_just_released("click") and dragged:
			dragged = false
			dropped.emit($Area2D)
