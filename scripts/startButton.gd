extends Button


# Called when the node enters the scene tree for the first time.

func _ready():
	print("Button has entered the scene")

func _pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")
	print("Welcome to the game")



# # Called every frame. 'delta' is the elapsed time since the previous frame.
# func _process(delta: float) -> void:
# 	pass
