extends Node2D

onready var player = $Player
onready var tilemap = $TileMap

func _ready():
	pass

func _input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			var local_position = tilemap.to_local(player.position)
			var player_cell = tilemap.world_to_map(local_position)
			print("Player world position: ", player.position)
			print("Player tilemap coordinates: ", player_cell)
			# TODO: Get the tile in the relative cardinal direction from the player.
			print("Mouse click world position: ", event.position)
			var mouse_player_delta = event.position - player.position
			if abs(mouse_player_delta.x) > abs(mouse_player_delta.y):
				if mouse_player_delta.x > 0:
					# Dig right
					tilemap.set_cell(player_cell.x + 1, player_cell.y, TileMap.INVALID_CELL)
				else:
					# Dig left
					tilemap.set_cell(player_cell.x - 1, player_cell.y, TileMap.INVALID_CELL)
			else:
				if mouse_player_delta.y > 0:
					# Dig down
					tilemap.set_cell(player_cell.x, player_cell.y + 1, TileMap.INVALID_CELL)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
