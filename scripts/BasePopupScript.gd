extends Popup

onready var current_level = get_tree().get_current_scene().get_name()

func _on_Continue_pressed():
	# Check current scene and dictionary
	# If current scene is in dictionary and is currently loaded
	# Then load the next level.
	print(current_level)
	match current_level:
		"Tutorial":
			pass
			#get_tree().change_scene("scenepathhere")
	pass


func _on_Exit_pressed():
	get_tree().quit()
