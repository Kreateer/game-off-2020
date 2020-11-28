extends Node

onready var levels = {"Main": "res://scenes/Main.tscn", "Tutorial": "res://levels/Tutorial.tscn"}

func current_level(level):
	if level == "Main":
		MusicController.play_music("MainTheme")
		return levels.Main
	
	if level == "Tutorial":
		MusicController.play_music("Gameplay")
		return levels.Tutorial
	
	pass
