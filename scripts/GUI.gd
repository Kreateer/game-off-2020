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
	get_node("/root/Tutorial/CanvasLayer/Score").text = str(score)

func show_game_over():
	show_message("Game Over!")
	$RetryButton.show()


# When the Start button is pressed
func _on_StartButton_pressed():
	$Title.hide()
	$StartButton.hide()
	$ExitButton.hide()
	emit_signal("game_start")
#	for root in get_tree():
#		if root == "Main":
#			get_tree().change_scene("res://scenes/Tutorial.tscn")
#		else:
#			break
	get_tree().change_scene("res://scenes/Tutorial.tscn")
#	for root in get_tree():
#		if root == "Tutorial":
#			root.new_game()
#		else:
#			break

# When the Exit button is pressed, the game closes.
# This will NOT save player progression.
func _on_ExitButton_pressed():
	get_tree().quit()


func _on_RetryButton_pressed():
	$Title.hide()
	$RetryButton.hide()
	emit_signal("game_start")
	var tutorial = self.get_parent()
	if tutorial.name == "Tutorial":
		tutorial.new_game()
	else:
		pass
