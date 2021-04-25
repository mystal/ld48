extends Node2D

onready var player = $Player
onready var tilemap = $TileMap
onready var tile_highlight = $SelectedTileHighlight
onready var camera = $Camera2D

func _ready():
	pass

func _process(delta):
	var highlighted_cell = get_highlighted_cell(get_global_mouse_position())
	if highlighted_cell != null:
		var local_position = tilemap.map_to_world(highlighted_cell)
		var global_position = tilemap.to_global(local_position)
		tile_highlight.position = global_position
		tile_highlight.visible = true
	else:
		tile_highlight.visible = false

	if Input.is_action_just_pressed("dig"):
		var cell = get_highlighted_cell(get_global_mouse_position())
		if cell != null:
			tilemap.damage_cell(cell.x, cell.y)

func get_highlighted_cell(mouse_position):
	var local_position = tilemap.to_local(player.position)
	var player_cell = tilemap.world_to_map(local_position)
	var mouse_player_delta = mouse_position - player.position
	if abs(mouse_player_delta.x) > abs(mouse_player_delta.y):
		if mouse_player_delta.x > 0:
			if tilemap.get_cell(player_cell.x + 1, player_cell.y) != TileMap.INVALID_CELL:
				return Vector2(player_cell.x + 1, player_cell.y)
		else:
			if tilemap.get_cell(player_cell.x - 1, player_cell.y) != TileMap.INVALID_CELL:
				return Vector2(player_cell.x - 1, player_cell.y)
	else:
		if mouse_player_delta.y > 0:
			if tilemap.get_cell(player_cell.x, player_cell.y + 1) != TileMap.INVALID_CELL:
				return Vector2(player_cell.x, player_cell.y + 1)
	return null

func _on_TileMap_block_was_hit():
	camera.start_shake(0.4)
