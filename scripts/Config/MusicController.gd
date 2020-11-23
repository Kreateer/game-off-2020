extends Node

var menu_theme = load("res://assets/audio/MenuTheme/LunaRun Menu-1.wav")

func _ready():
	pass

func play_music(type):
	if type == "MainTheme":
		$Music.stream = menu_theme
		$Music.volume_db = -10
		$Music.play()
	# Add other songs here
	
	else:
		pass

func stop_music():
	$Music.stop()
