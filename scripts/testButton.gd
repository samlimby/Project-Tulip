extends Button

func _pressed():
	print("test button pressed");
	print(gameManager.score);

	gameManager.score += 1;



