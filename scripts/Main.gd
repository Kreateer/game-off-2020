extends Node

var score
export (int) var oxygen
onready var oxygen_bar = get_node("CanvasLayer/Oxygen/OxygenBar")
onready var oxygen_timer = get_node("CanvasLayer/Oxygen/OxygenTimer")
func _ready():
	oxygen_bar.max_value = oxygen
	oxygen_bar.value = oxygen
	oxygen_timer.wait_time = oxygen

#func _process(delta):
#	pass

func _physics_process(delta):
	oxygen_bar.value = oxygen_timer.time_left

func new_game():
	score = 0
	$Player.show()
	$CanvasLayer/Score.show()
	$CanvasLayer/PauseScene.show()
	$CanvasLayer/Oxygen.show()
	oxygen_timer.start()
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

func _on_OxygenTimer_timeout():
	$Player.player_oxygen(1)
