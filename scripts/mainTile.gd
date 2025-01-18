extends Node2D

func _ready():
    gameManager.tilemap = $"prototype-tile"
    gameManager.overlay_tilemap = $"prototype-tile_overlay"