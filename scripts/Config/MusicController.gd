extends Node

var menu_theme = load("res://assets/audio/MenuTheme/LunaRun Menu-1.wav")
var gameplay = load("res://assets/audio/Gameplay/Going down-1.wav")



func _ready():
	pass

func _process(delta):
	pass

func play_music(type):	
	if type == "MainTheme":
		$Music.stream = menu_theme
		$Music.volume_db = -10
		$Music.play()
	# Add other songs here
	elif type == "Gameplay":
		$Music.stream = gameplay
		$Music.volume_db = -15
		$Music.play()
	
	else:
		stop_music()

func stop_music():
	$Music.stop()
