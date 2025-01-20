extends Node2D

@onready var main_scene = get_tree().get_root().get_node("main")
@onready var foundationTiles: TileMapLayer = get_node("/root/main/prototype-tile")
@onready var buildingTiles: TileMapLayer = get_node("/root/main/building-tile")
@onready var buildButton: Button = get_node("gameUIContainer/GamePanel/buildButton")

func _ready():
    if buildButton:
        buildButton.pressed.connect(_on_build_button_pressed)

func _input(_event):
    if Input.is_action_just_pressed("left-click"):

        print("mouse click")

        var mouse_pos = get_global_mouse_position()
        var foundation_mouse_tile = foundationTiles.local_to_map(mouse_pos)
        var building_mouse_tile = buildingTiles.local_to_map(mouse_pos)

        # print(mouse_tile)

        var sourceID = 0
        var building_atlas_coord = Vector2i(2,0)

        buildingTiles.set_cell(building_mouse_tile, sourceID, building_atlas_coord)


func _on_build_button_pressed():
    print("button is pressed")