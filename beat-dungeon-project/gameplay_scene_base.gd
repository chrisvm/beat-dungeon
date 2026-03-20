extends Node

@onready var game_view: SubViewportContainer = $Control/GameView
@onready var subviewport: SubViewport = $Control/GameView/SubViewport
@onready var right_panel: Panel = $Control/RightPanel

func _ready() -> void:
	_apply_split()
	game_view.resized.connect(_on_game_view_resized)
	SelectionManager.game_viewport = subviewport

func _apply_split() -> void:
	var f := GameSettingsLoader.data.game_view_fraction
	game_view.anchor_right = f
	game_view.offset_right = 0.0
	right_panel.anchor_left = f
	right_panel.offset_left = 0.0
	var vp := get_viewport().get_visible_rect().size
	subviewport.size = Vector2i(int(vp.x * f), int(vp.y))

func _on_game_view_resized() -> void:
	subviewport.size = Vector2i(game_view.size)
