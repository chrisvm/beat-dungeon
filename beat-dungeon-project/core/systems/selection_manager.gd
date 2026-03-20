extends Node

signal unit_selected(unit: Node)

@export var unit_collision_mask := 1 << 1  # layer 2 (Selection)
var selected_units: Array[Node] = []

func clear() -> void:
	selected_units.clear()
	unit_selected.emit(null)

func add(node: Node) -> void:
	selected_units = [node]
	unit_selected.emit(node)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			var unit = _unit_under_mouse()
			if unit:
				add(unit)
			else:
				clear()

func _unit_under_mouse() -> Node:
	var screen_pos := get_viewport().get_mouse_position()
	var pos := get_viewport().get_canvas_transform().affine_inverse() * screen_pos

	var query := PhysicsPointQueryParameters2D.new()
	query.position = pos
	query.collide_with_areas = true
	query.collision_mask = unit_collision_mask

	var space := get_viewport().world_2d.direct_space_state
	var hits := space.intersect_point(query)
	if hits.is_empty():
		return null

	# ClickArea is hit → return the parent Unit
	return hits[0].collider.get_parent()
