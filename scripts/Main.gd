extends Node

var score

#func _ready():
#	pass

#func _process(delta):
#	pass

func new_game():
	score = 0
	$Player.show()
	$CanvasLayer/Score.show()
	$CanvasLayer/PauseScene.show()
	#$Player.start($Player/StartPosition.position)
	#$StartTimer.start()
	$GUI.update_score(score)
	#$Music.play()

func game_over():
	#ScoreTimer.stop()
	$GUI.show_game_over()
	#$Music.stop()

func _on_GUI_game_start():
	new_game()
