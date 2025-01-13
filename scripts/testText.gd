extends Label

func _ready():
    # Convert to string since label.text expects a string
    text = str(gameManager.score)

# If you want to update it continuously:
func _process(_delta):
    text = str(gameManager.score)