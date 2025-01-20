extends Button

@onready var foundationTiles: TileMapLayer = $"prototype-tile"
@onready var buildingTiles: TileMapLayer = $"building-tile"

func _ready():
    pass

func _input(_event):
    if Input.is_action_just_pressed("left-click"):
        print("left mouse clicked")