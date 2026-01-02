extends CanvasLayer

@onready var sprite := $Sprite2D
@export var tile_set: TileSet
var tile_size: int
var atlas_source: TileSetAtlasSource


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	# use tileset as source, we need to create a TileSetAtlasSource
	var source := tile_set.get_source(0)
	atlas_source = source as TileSetAtlasSource
	sprite.texture = atlas_source.texture
	
	# get tile_size from the tileset
	tile_size = atlas_source.texture_region_size.x

	set_cursor_tile(Vector2i(7, 1))

func _process(delta: float) -> void:
	sprite.global_position = get_viewport().get_mouse_position()
	
func set_cursor_tile(coords: Vector2i):
	var translated_coords := Vector2i()
	if coords.x != 0:
		translated_coords.x = (coords.x * tile_size) + 1
	if coords.y != 0:
		translated_coords.y = (coords.y * tile_size) + 1
	sprite.region_rect = Rect2(translated_coords, Vector2(tile_size, tile_size))
