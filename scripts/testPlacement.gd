extends Sprite2D

# Tracks whether the sprite is selected
var is_selected = false

# Offset for aligning the sprite to the mouse
var customOffset = Vector2(-1, -1)

func _process(_delta):
	# If the sprite is selected, make it follow the mouse based on the tilemap
	if is_selected:
		# Get the mouse position in local coordinates
		var local_mouse_pos = gameManager.tilemap.to_local(get_global_mouse_position())
		
		# Convert to tile coordinates
		var mouse_tile = gameManager.tilemap.local_to_map(local_mouse_pos)

		# Apply the offset to the tile coordinates
		mouse_tile = Vector2i(mouse_tile.x + int(customOffset.x), mouse_tile.y + int(customOffset.y))
		
		# Convert back to world position
		var world_pos = gameManager.tilemap.map_to_local(mouse_tile)
		
		# Add the half-tile offset to center on the tile
		var tile_size = gameManager.tilemap.tile_set.tile_size
		world_pos += Vector2(tile_size.x / 2, tile_size.y / 2)
		
		global_position = world_pos

func _input(event):
	# If the left mouse button is clicked
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		# Toggle the selected state
		is_selected = !is_selected
		
		# If deselected, snap to the current tile position
		if not is_selected:
			var local_mouse_pos = gameManager.tilemap.to_local(get_global_mouse_position())
			var mouse_tile = gameManager.tilemap.local_to_map(local_mouse_pos)

			# Apply the offset to the tile coordinates
			mouse_tile = Vector2i(mouse_tile.x + int(customOffset.x), mouse_tile.y + int(customOffset.y))
			
			# Convert back to world position
			var world_pos = gameManager.tilemap.map_to_local(mouse_tile)
			var tile_size = gameManager.tilemap.tile_set.tile_size
			world_pos += Vector2(tile_size.x / 2, tile_size.y / 2)
			
			global_position = world_pos
			print("Sprite placed at: ", mouse_tile)
