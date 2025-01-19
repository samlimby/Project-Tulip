extends Button

var custom_popup: ColorRect
var is_popup_open := false
var house_button: Button
var workshop_button: Button

# Variables for placement system
var current_building_sprite: Sprite2D = null
var is_placing = false
var customOffset = Vector2(-1, -1)

func _ready():
    setup_popup_menu()

func setup_popup_menu():
    custom_popup = ColorRect.new()
    add_child(custom_popup)
    
    custom_popup.color = Color(0.2, 0.2, 0.2, 0.9)
    custom_popup.custom_minimum_size = Vector2(200, 300)
    custom_popup.visible = false
    custom_popup.z_index = 1
    custom_popup.set_anchors_preset(Control.PRESET_CENTER)
    custom_popup.mouse_filter = Control.MOUSE_FILTER_STOP
    
    var container = VBoxContainer.new()
    container.set_anchors_preset(Control.PRESET_FULL_RECT)
    container.add_theme_constant_override("separation", 10)
    custom_popup.add_child(container)
    
    var options = ["House", "Farm", "Workshop", "Mine"]
    for option in options:
        var build_button = Button.new()
        build_button.text = option
        build_button.custom_minimum_size.y = 40
        build_button.pressed.connect(_on_build_option_selected.bind(option))
        
        if option == "House":
            house_button = build_button
        if option == "Workshop":
            workshop_button = build_button
            
        container.add_child(build_button)
    
    pressed.connect(_on_button_clicked)

func _on_button_clicked():
    if !is_popup_open:
        custom_popup.global_position = Vector2(400, 400)
        custom_popup.visible = true
        is_popup_open = true

func _on_build_option_selected(option: String):
    print("Selected build option: ", option)
    create_building_sprite(option)
    close_popup()

func create_building_sprite(building_type: String):
    # Clear any existing placement sprite
    if current_building_sprite:
        current_building_sprite.queue_free()
    
    # Create new sprite
    current_building_sprite = Sprite2D.new()
    
    # Load appropriate texture based on building type
    var texture_path = "res://art/"  # Adjust this path
    match building_type:
        "House":
            texture_path += "testTexture.png"
        "Farm":
            texture_path += "testTexture.png"
        "Workshop":
            texture_path += "testTexture.png"
        "Mine":
            texture_path += "testTexture.png"
    
    # Load and set the texture
    var texture = load(texture_path)
    if texture:
        current_building_sprite.texture = texture
    
    # Add to scene and start placement mode
    add_child(current_building_sprite)
    is_placing = true
    current_building_sprite.modulate.a = 0.5  # Make semi-transparent while placing

func _process(_delta):
    if is_placing and current_building_sprite:
        # Convert mouse position to tilemap coordinates
        var local_mouse_pos = gameManager.tilemap.to_local(get_global_mouse_position())
        var mouse_tile = gameManager.tilemap.local_to_map(local_mouse_pos)
        
        print("Mouse Tile Coordinates:", mouse_tile)

        # Retrieve tile data
        var tile_data = gameManager.tilemap.get_cell_tile_data(mouse_tile)  # No layer index needed
        if tile_data:
            print("Tile Data:", tile_data)
        else:
            print("No tile found at:", mouse_tile)

        # Update the building sprite's position
        var world_pos = gameManager.tilemap.map_to_local(mouse_tile)
        current_building_sprite.global_position = world_pos



func _input(event):
    # Handle clicking outside popup
    if is_popup_open and event is InputEventMouseButton:
        if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
            var click_pos = event.global_position
            var popup_rect = custom_popup.get_global_rect()
            
            if not popup_rect.has_point(click_pos) and not get_global_rect().has_point(click_pos):
                close_popup()
    
    # Handle building placement
    if is_placing and current_building_sprite and event is InputEventMouseButton:
        if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
            place_building()
        elif event.pressed and event.button_index == MOUSE_BUTTON_RIGHT:
            cancel_placement()

func place_building():
    if current_building_sprite:
        current_building_sprite.modulate.a = 1.0  # Make fully opaque
        current_building_sprite.z_index = 0
        var placed_position = gameManager.tilemap.local_to_map(
            gameManager.tilemap.to_local(current_building_sprite.global_position)
        )
        print("Building placed at: ", placed_position)
        
        # Reset placement state
        current_building_sprite = null
        is_placing = false

func cancel_placement():
    if current_building_sprite:
        current_building_sprite.queue_free()
        current_building_sprite = null
        is_placing = false

func close_popup():
    custom_popup.visible = false
    is_popup_open = false

func _unhandled_input(event):
    if event is InputEventKey and event.pressed and event.keycode == KEY_ESCAPE:
        if is_placing:
            cancel_placement()
        elif is_popup_open:
            close_popup()
