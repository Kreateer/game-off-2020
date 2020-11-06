extends CanvasLayer

signal game_start

func show_message(text):
	$Title.text = text
	$Title.show()
	#$MessageTimer.start()

func game_win():
	pass

func game_lose():
	pass

func update_score(score):
	#get_node("/root/Main/Player/Camera2D/Score").text = str(score)
	#get_node("/root/Main/Player/Camera2D/Score").text = str(score)
	get_node("/root/Main/CanvasLayer/Score").text = str(score)

func show_game_over():
	show_message("Game Over!")
	$RetryButton.show()


# When the Start button is pressed
func _on_StartButton_pressed():
	$Title.hide()
	$StartButton.hide()
	$ExitButton.hide()
	emit_signal("game_start")

# When the Exit button is pressed, the game closes.
# This will NOT save player progression.
func _on_ExitButton_pressed():
	get_tree().quit()


func _on_RetryButton_pressed():
	$RetryButton.hide()
	emit_signal("game_start")
