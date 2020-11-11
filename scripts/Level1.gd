extends Node

var score
export (int) var oxygen
onready var oxygen_bar = $Player/HUD/OxygenBar
onready var oxygen_timer = $Player/HUD/OxygenTimer
func _ready():
	something()
	oxygen_bar.max_value = oxygen
	oxygen_bar.value = oxygen
	oxygen_timer.wait_time = oxygen

#func _process(delta):
#	pass

func _physics_process(delta):
	oxygen_bar.value = oxygen_timer.time_left

func something():
	score = 0
#	$Player.show()
#	$Player/CanvasLayer/Score.show()
#	$Player/CanvasLayer/PauseScene.show()
#	$Player/CanvasLayer/Oxygen.show()
#	$Player/CanvasLayer/OxygenBar.show()
	oxygen_timer.start()
	#$GUI.update_score(score)
	#$Music.play()


func _on_OxygenTimer_timeout():
	$Player.player_oxygen(1)
