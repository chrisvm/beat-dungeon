extends Node

const SETTINGS_PATH := "res://core/settings/game_settings.tres"
var data: GameSettings

func _init() -> void:
	data = load(SETTINGS_PATH)
