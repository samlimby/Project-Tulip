extends Node2D

@onready var buildingTiles: TileMapLayer = get_node("/root/main/building-tile")
@onready var buildButton: Button = get_node("gameUIContainer/GamePanel/buildButton")

var popup_menu: PopupMenu
var is_placing_house = false
var preview_pos = Vector2i(-1, -1)  # Invalid initial position

func _ready():
    if buildButton:
        buildButton.pressed.connect(_on_build_button_pressed)
    setup_popup_menu()

func setup_popup_menu():
    popup_menu = PopupMenu.new()
    add_child(popup_menu)
    popup_menu.add_item("House", 0)
    popup_menu.id_pressed.connect(_on_menu_item_selected)

func _on_build_button_pressed():
    popup_menu.position = get_viewport().get_mouse_position()
    popup_menu.popup()

func _on_menu_item_selected(_id: int):
    is_placing_house = true
    popup_menu.hide()

func _process(_delta):
    if is_placing_house:
        # Hover logic for preview tile
        var mouse_pos = get_global_mouse_position()
        var new_pos = buildingTiles.local_to_map(mouse_pos)

        if new_pos != preview_pos:
            # Remove previous preview if valid
            if preview_pos != Vector2i(-1, -1):
                var source_id = buildingTiles.get_cell_source_id(preview_pos)
                if source_id == 0:  # Ensure it's a preview tile
                    buildingTiles.set_cell(preview_pos, -1)  # Clear preview tile

            # Set new preview
            buildingTiles.set_cell(new_pos, 0, Vector2i(2, 0))
            preview_pos = new_pos

func _input(event):
    if is_placing_house and event is InputEventMouseButton:
        if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
            _set_tile()

func _set_tile():
    # Place the permanent tile at the preview position
    if preview_pos != Vector2i(-1, -1):  # Ensure the preview position is valid
        buildingTiles.set_cell(preview_pos, 0, Vector2i(2, 0))
        print("Tile placed at:", preview_pos)

    # Reset preview
    preview_pos = Vector2i(-1, -1)
    is_placing_house = false
