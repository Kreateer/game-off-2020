extends Popup

onready var tree = get_tree()
onready var current_level = tree.get_current_scene().get_name()

func _on_Continue_pressed():
	# Check current scene and dictionary
	# If current scene is in dictionary and is currently loaded
	# Then load the next level.
	match current_level:
		"Tutorial":
			tree.change_scene("res://levels/Level1.tscn")
		"Level1":
			tree.change_scene("res://levels/Level2.tscn")
		"Level3":
			tree.change_scene("res://levels/Level3.tscn")
	pass


func _on_Exit_pressed():
	tree.quit()
