extends Camera2D

@export var zoom_speed: float = 0.1
@export var min_zoom: float = 0.25
@export var max_zoom: float = 4.0

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			_zoom_toward_mouse(1.0 + zoom_speed)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			_zoom_toward_mouse(1.0 - zoom_speed)

func _zoom_toward_mouse(factor: float) -> void:
	var mouse_world_before := get_global_mouse_position()
	var new_zoom_val := clampf(zoom.x * factor, min_zoom, max_zoom)
	zoom = Vector2(new_zoom_val, new_zoom_val)
	var mouse_world_after := get_global_mouse_position()
	position += mouse_world_before - mouse_world_after
