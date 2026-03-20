extends Control

@onready var unit_name_label: Label = $PanelContainer/VBoxContainer/UnitNameLabel
@onready var health_label: Label = $PanelContainer/VBoxContainer/HealthLabel

func _ready() -> void:
	hide()
	SelectionManager.unit_selected.connect(_on_unit_selected)

func _on_unit_selected(unit: Node) -> void:
	# if null, deselection event
	if unit == null:
		hide()
		return

	unit_name_label.text = unit.unit_name
	health_label.text = "HP: %d / %d" % [unit.health, unit.stats.max_health]
	show()
