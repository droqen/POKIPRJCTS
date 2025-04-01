@tool
extends Node2D
class_name PokiStage

@export var width : int = 400
@export var height : int = 400

func _draw() -> void:
	if Engine.is_editor_hint():
		draw_rect(Rect2(0,0,width,height),Color.RED,false)
		draw_rect(Rect2(-2,-2,width+4,height+4),Color.RED,false)
