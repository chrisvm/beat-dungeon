extends Node2D
class_name SelectionManager

@export var unit_collision_mask := 1 << 1  # layer 2
var selected_units: Array[Node] = []

func clear() -> void:
	selected_units.clear()
	
func add(node: Node) -> void:
	pass

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			var unit = _unit_under_mouse()
			if unit:
				# todo: handle adding the unit to the selected_units
				# 		array and firing off the correct signals
				pass
			else:
				clear()
				
func _unit_under_mouse() -> Node:
	var space := get_world_2d().direct_space_state
	var pos := get_viewport().get_mouse_position()
	
	var query := PhysicsPointQueryParameters2D.new()
	query.position = pos
	query.collide_with_areas = true
	query.collision_mask = unit_collision_mask
	
	var hits := space.intersect_point(query)
	if hits.is_empty():
		return null

	# ClickArea is hit → return the parent Unit
	return hits[0].collider.get_parent()
