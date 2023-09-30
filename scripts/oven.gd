extends Node2D

@export var temp_change_speed: float
@export var oven_opened_texture: Texture
@export var oven_opened_top_texture: Texture
@export var oven_closed_texture: Texture

var aimed_temp: int = 0
var current_temp: float = 0
var is_opened: bool = false

func _process(delta):
	if(aimed_temp != round(current_temp)):
		#current_temp = lerpf(current_temp, aimed_temp, temp_change_speed * delta)
		current_temp += temp_change_speed * delta
		
		if(int(round(current_temp)) % 5 == 0):
			%CurrentTemp.text = str(round(current_temp)) + "°F"


func _on_door_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("click"):
		if !is_opened:
			$Sprite2D.texture = oven_opened_texture
			$Sprite2D.position = Vector2(125,40)

				
		elif is_opened:
			$Sprite2D.texture = oven_closed_texture
			$Sprite2D.position = Vector2(0,0)
			
		$Sprite2DTop.visible = is_opened
		
		$Door/CollisionShape2D.disabled = not is_opened
		$Door/CollisionPolygon2D.disabled = is_opened
		
		for shelf in $Shelves.get_children():
			shelf.active = not is_opened
			
		is_opened = not is_opened
		
		return true
