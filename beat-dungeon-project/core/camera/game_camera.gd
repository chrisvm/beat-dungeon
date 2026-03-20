extends Camera2D

@export var zoom_speed: float = 0.1
@export var min_zoom: float = 0.25
@export var max_zoom: float = 4.0

# Width fraction of viewport reserved for the game view (left side)
@export var game_view_fraction: float = 0.6

func _ready() -> void:
	_center_on_game_view()

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
	# Shift camera so the world point under the mouse stays fixed
	var mouse_world_after := get_global_mouse_position()
	position += mouse_world_before - mouse_world_after

# Offsets the camera so its view is centered on the left game_view_fraction of the viewport
func _center_on_game_view() -> void:
	var vp_width := float(get_viewport().get_visible_rect().size.x)
	var game_center_x := vp_width * game_view_fraction * 0.5
	var vp_center_x := vp_width * 0.5
	offset.x = (vp_center_x - game_center_x) / zoom.x
