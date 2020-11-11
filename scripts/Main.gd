extends Node

var score
export (int) var oxygen
onready var oxygen_bar = get_node("CanvasLayer/Oxygen/OxygenBar")
onready var oxygen_timer = get_node("CanvasLayer/Oxygen/OxygenTimer")
onready var darkness = get_node("Darkness")

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
	darkness.reset()
	$Player.reset()
	$Player.show()
	$CanvasLayer/Score.show()
	$CanvasLayer/PauseScene.show()
	$CanvasLayer/Oxygen.show()
	oxygen_timer.start()
	#$Player.start($Player/StartPosition.position)
	#$StartTimer.start()
	yield(get_tree().create_timer(1.0), "timeout")
	darkness.start()
	$GUI.update_score(score)
	#$Music.play()

func game_over():
	#ScoreTimer.stop()
	darkness.pause()
	$GUI.show_game_over()
	#$Music.stop()

func _on_GUI_game_start():
	new_game()

func _on_OxygenTimer_timeout():
	$Player.player_oxygen(1)

func _on_Player_Dead():
	game_over()
