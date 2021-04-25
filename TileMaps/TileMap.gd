extends TileMap

const DirtStats = preload("res://Blocks/DirtStats.tres")
const ClayStats = preload("res://Blocks/ClayStats.tres")
const GemStats = preload("res://Blocks/GemStats.tres")
const StoneStats = preload("res://Blocks/StoneStats.tres")

signal block_was_hit()

var block_healths = Dictionary()

func _ready():
	pass

func damage_cell(cell_x, cell_y):
	var stats = get_block_stats(cell_x, cell_y)
	if stats == null or stats.invulnerable:
		return

	var cell = Vector2(cell_x, cell_y)
	var current_health = block_healths.get(cell, stats.durability)
	if current_health > 1:
		block_healths[cell] = current_health - 1
	else:
		set_cell(cell_x, cell_y, TileMap.INVALID_CELL)
		block_healths.erase(cell)

	emit_signal("block_was_hit")

func get_block_stats(cell_x, cell_y):
	var tile_id = get_cell(cell_x, cell_y)
	if tile_id == INVALID_CELL:
		return null
	var name = tile_set.tile_get_name(tile_id)
	match name:
		"dirt":
			return DirtStats
		"clay":
			return ClayStats
		"gem":
			return GemStats
		"stone":
			return StoneStats
	return null
