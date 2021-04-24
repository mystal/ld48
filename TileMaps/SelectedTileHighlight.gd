extends Sprite

onready var player = get_node("../Player")
onready var tilemap = get_node("../TileMap")

func _ready():
	pass

func _process(delta):
	var highlighted_cell = get_highlighted_cell()
	if highlighted_cell != null:
		var local_position = tilemap.map_to_world(highlighted_cell)
		var global_position = tilemap.to_global(local_position)
		position = global_position
		visible = true
	else:
		visible = false

func get_highlighted_cell():
	var mouse_position = get_viewport().get_mouse_position()
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
