extends Node2D

const MIN_PIXEL_GUTTER : int = 10

func update_camera_center_stage(camera:Camera2D, stage:PokiStage) -> void:
	var viewport_size = get_viewport_rect().size
	var stage_size = Vector2(stage.width, stage.height)
	var pixel_scale : int = int(min(
		(viewport_size.x-MIN_PIXEL_GUTTER-MIN_PIXEL_GUTTER)
			/stage.width,
		(viewport_size.y-MIN_PIXEL_GUTTER-MIN_PIXEL_GUTTER)
			/stage.height
	))
	if pixel_scale < 1: pixel_scale = 1
	var scaled_stage_size = stage_size * pixel_scale
	camera.zoom = Vector2(pixel_scale,pixel_scale)
	camera.position = (scaled_stage_size-viewport_size)/2/pixel_scale

func _physics_process(_delta: float) -> void:
	update_camera_center_stage($Camera2D, $Stage)
