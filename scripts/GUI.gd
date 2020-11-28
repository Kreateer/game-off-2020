extends CanvasLayer

signal game_start

onready var tree = get_tree()

func show_message(text):
	$Title.text = text
	$Title.show()
	#$MessageTimer.start()

func game_win():
	pass

func game_lose():
	pass

func _ready():
	MusicController.play_music("MainTheme")

func _process(delta):
	var current_scene = tree.current_scene
	if current_scene.name == "Main":
		$TitleAnimation.play("TitleBob")
		$TitleAnimation/GameTitle.show()
	
	else:
		$TitleAnimation.stop()
		$TitleAnimation/GameTitle.hide()

# Updates the Score label for the Player
#func update_score(score):
	#get_node("/root/Main/Player/Camera2D/Score").text = str(score)
	#get_node("/root/Main/Player/Camera2D/Score").text = str(score)
#	get_node("/root/Tutorial/CanvasLayer/Score").text = str(score)

# Change scene to Tutorial level to start the game
func _on_StartButton_pressed():
	$StartButton.hide()
	$ExitButton.hide()
	$TitleAnimation.stop()
	$TitleAnimation/GameTitle.hide()
	emit_signal("game_start")
	
	
#	for root in get_tree():
#		if root == "Main":
#			get_tree().change_scene("res://scenes/Tutorial.tscn")
#		else:
#			break
	MusicController.stop_music()
	$LoadingScreen.show()
	yield(tree.create_timer(3), "timeout")
	$LoadingScreen.hide()
	
	tree.change_scene("res://levels/Tutorial.tscn")
	#SceneLoader.goto_scene("res://levels/Tutorial.tscn")
#	for root in get_tree():
#		if root == "Tutorial":
#			root.new_game()
#		else:
#			break

# When the Exit button is pressed, the game closes.
# This will NOT save player progression.
func _on_ExitButton_pressed():
	tree.quit()

# Hide 'Game Over' screen and reset progress to start of level
func _on_RetryButton_pressed():
	$Title.hide()
	tree.call_group("DeathButtons", "hide")
	emit_signal("game_start")
	var tutorial = self.get_parent()
	if tutorial.name == "Tutorial":
		tutorial.new_game()
	else:
		pass

func _on_Player_Dead(cause):
	yield(tree.create_timer(2), "timeout")
	match cause:
		Constants.SUFFOCATE:
			show_message("Game Over!\nYou've Suffocated!")
		Constants.FALL:
			show_message("Game Over!\nYou've fallen off the map!")
		Constants.DARKNESS:
			show_message("Game Over!")
		Constants.HEALTH:
			show_message("Game Over!")
	
	tree.call_group("DeathButtons", "show")
	$FadeIn/OverlayPanel.show()
	$FadeIn.play("FadeOut")

func _on_DeathExitButton_pressed():
	tree.quit()
