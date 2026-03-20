class_name UnitBase
extends CharacterBody2D

@export var unit_name: String = "Unit"
@export var base_stats: UnitStats

var stats: UnitStats
var health: int

func _ready() -> void:
	if base_stats:
		stats = base_stats.duplicate()
	else:
		stats = UnitStats.new()
	health = stats.max_health
	$AnimationPlayer.play("idle")

func get_stat(stat_name: StringName) -> float:
	return float(stats.get(stat_name))
